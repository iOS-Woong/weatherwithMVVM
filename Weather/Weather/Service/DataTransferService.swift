//
//  DataTransferService.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/13.
//

import Foundation

struct DataTransferService {
    private let endPoint = EndPoint()
    private let service = NetworkService()
    
    func fetchAllCitiesCurrentWeather(completion: @escaping ([CityWeather]) -> Void) {
        let dispatchGroup = DispatchGroup()
        var citiesWeather: [CityWeather] = []
        
        for city in QueryItem.allCases {
            dispatchGroup.enter()
            let url = endPoint.url(city: city, for: .weather)
            service.fetch(url: url, type: CurrentWeather.self) { result in
                switch result {
                case .success(let weather):
                    let cityWeather = CityWeather(coordinate: Coordinate(lon: weather.coord.lon, lat: weather.coord.lat),
                                                  temparature: Temparature(temp: weather.main.temp, tempMin: weather.main.tempMin, tempMax: weather.main.tempMax),
                                                  description: weather.weather[0].description,
                                                  wind: WindInfo(speed: weather.wind.speed, deg: weather.wind.deg))
                    citiesWeather.append(cityWeather)
                case .failure(let error):
                    print(error)
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(citiesWeather)
        }
    }
    
    func fetchFiveDaysForecast(completion: @escaping ([Forecast]) -> Void) {
        let url = endPoint.url(city: .seoul, for: .forecast)
        
        service.fetch(url: url, type: FiveDayWeatherForecast.self) { result in
            switch result {
            case .success(let fivedayForecast):
                let limit = 27
                let forecastList: [Forecast] = fivedayForecast.list
                    .prefix(limit)
                    .flatMap { list in
                        list.weather.map { weather in
                            Forecast(dt: list.dtTxt, temp: list.main.temp, icon: weather.icon)
                        }
                    }
                
                completion(forecastList)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}


struct Forecast {
    let dt: String
    let temp : Double
    let icon: String
}

struct CityWeather { // TODO: 필요한 프로퍼티가 더 있다면 추가해야함.
    let coordinate: Coordinate
    let temparature: Temparature
    let description: String
    let wind: WindInfo
}

struct Coordinate {
    let lon: Double
    let lat: Double
}

struct Temparature {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
}

struct WindInfo {
    let speed: Double
    let deg: Int
}
