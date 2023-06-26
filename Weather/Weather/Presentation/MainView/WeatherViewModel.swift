//
//  MainViewModel.swift
//  Weather
//
//  Created by 서현웅 on 2023/05/25.
//

import Foundation

enum Page: Int, CaseIterable {
    case seoul, busan, incheon, daegu, daejeon, gwhangju, ulsan, sejong
}

class WeatherViewModel {
    var page: Page
        
    private let usecase = ProcessWeatherUsecase()
    
    var forecasts: Observable<[Forecast]?> = .init(nil)
    var weathers: Observable<[CityWeather]?> = .init(nil)
    
    init(page: Page) {
        self.page = page
    }
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
