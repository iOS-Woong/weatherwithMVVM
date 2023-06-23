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

extension WeatherViewModel {
    func fetchWeatherData() {
        usecase.fetchFiveDaysForecast { self.forecasts.value = $0 }
        usecase.fetchAllCitiesCurrentWeather { self.weathers.value = $0 }
    }
    
    func fetchWeatherIcon(iconString: String , completion: @escaping (Data) -> Void) {
        usecase.fetchWeatherIcon(iconString: iconString, completion: completion)
    }
}
