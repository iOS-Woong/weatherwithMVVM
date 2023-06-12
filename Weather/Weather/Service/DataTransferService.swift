//
//  DataTransferService.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/13.
//

import Foundation

struct DataTransferService {
    typealias WeatherOutput = ([CityWeather]) -> Void
    typealias ForecastOutput = (Forecast) -> Void
    
    private let endPoint = EndPoint()
    private let service = NetworkService()
    
    func fetchAllCitiesCurrentWeather(completion: @escaping WeatherOutput) {
        
        for city in QueryItem.allCases {
            
        }
    }
    
    func fetchFiveDaysForecast(completion: @escaping ForecastOutput) {
        let url = endPoint.url(city: .seoul, for: .forecast)
        
    }
}


struct Forecast { // TODO: 사용할 데이터에 맞게 타입을 수정해야함
    let name: String
    let description : String
}

struct CityWeather { // TODO: 사용할 데이터에 맞게 타입을 수정해야함
    let name: String
    let description : String
}
