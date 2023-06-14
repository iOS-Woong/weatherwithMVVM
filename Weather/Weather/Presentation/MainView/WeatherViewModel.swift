//
//  MainViewModel.swift
//  Weather
//
//  Created by 서현웅 on 2023/05/25.
//

import Foundation

class WeatherViewModel {
    private let usecase = ProcessWeatherUsecase()
    
    var forecasts: Observable<[Forecast]?> = .init(nil)
    var weathers: Observable<[CityWeather]?> = .init(nil)
    
}


// Test함수
extension WeatherViewModel {
    func testUUIDs(count: Int) -> [UUID] {
        var uuids = [UUID]()
        let index = count - 1
        
        for _ in 0...index {
            let uuid = UUID()
            uuids.append(uuid)
        }
        return uuids
    }
}
