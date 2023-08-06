//
//  ProcessWeatherUsecase.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/13.
//

import Foundation

struct ProcessWeatherUsecase {
    private let endPoint = EndPoint()
    private let service = NetworkRepository()
    private let imageManager = ImageManager()
    
    func fetchAllCitiesCurrentWeather(completion: @escaping ([CityWeather]) -> Void) {
        let dispatchGroup = DispatchGroup()
        var citiesWeather: [CityWeather] = []
        
        for city in QueryItem.allCases {
            dispatchGroup.enter()
            let url = endPoint.url(city: city, for: .weather)
            service.fetch(url: url, type: CurrentWeather.self) { result in
                switch result {
                case .success(let weather):
                    let cityWeather = CityWeather(weatherId: weather.weather[0].id,
                                                  name: weather.name,
                                                  icon: weather.weather[0].icon,
                                                  coordinate: Coordinate(lon: weather.coord.lon, lat: weather.coord.lat),
                                                  temparature: Temparature(detail: DetailStuff(pressure: weather.main.pressure,
                                                                                               humidity: weather.main.humidity,
                                                                                               visibility: weather.visibility),
                                                                           temp: weather.main.temp,
                                                                           tempMin: weather.main.tempMin - 3, // API의 온도가 부정확하여 최저온도 가중치를 줍니다.
                                                                           tempMax: weather.main.tempMax + 3, // API의 온도가 부정확하여 최고온도 가중치를 줍니다.
                                                                           sensoryTemp: weather.main.feelsLike),
                                                  description: weather.weather[0].description,
                                                  wind: WindInfo(speed: weather.wind.speed,
                                                                 deg: weather.wind.deg),
                                                  cloud: Cloud(Cloudiness: weather.clouds.all),
                                                  sun: Sun(sunrise: weather.sys.sunrise,
                                                           sunset: weather.sys.sunset))
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
    
    func getImageDataFromImageManager(url: URL,
                                      completion: @escaping (Data) -> Void) {
        imageManager.retriveImage(url.absoluteString) { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
