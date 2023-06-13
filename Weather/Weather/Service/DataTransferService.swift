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

struct CityWeather { // TODO: 사용할 데이터에 맞게 타입을 수정해야함
    let name: String
    let description : String
}

/*
 
 dtTxt
 main → temp
 
 weather → icon
 
 */
