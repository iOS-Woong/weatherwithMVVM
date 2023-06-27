//
//  MainViewModel.swift
//  Weather
//
//  Created by 서현웅 on 2023/05/25.
//

import Foundation

enum Page: String, CaseIterable {
    case seoul, busan, incheon, daegu, daejeon, gwangju, ulsan, sejong
    
    var capitalizedPage: String {
        let capitalizedFirst = self.rawValue.prefix(1).capitalized
        let exceptFirst = self.rawValue.dropFirst()
        
        return capitalizedFirst + exceptFirst
    }
}

class WeatherViewModel {
    var page: Page
        
    private let usecase = ProcessWeatherUsecase()
    
    var forecasts: Observable<[Forecast]?> = .init(nil)
    var cityWeathers: [CityWeather]
    
    var cityWeathersExcludingCurrentPage: [CityWeather] {
        return cityWeathers.filter { $0.name != page.capitalizedPage }
    }
    
    init(page: Page, cityWeathers: [CityWeather]) {
        self.page = page
        self.cityWeathers = cityWeathers
    }
}

extension WeatherViewModel {
    func fetchWeatherData() {
        usecase.fetchFiveDaysForecast { self.forecasts.value = $0 }
    }
    
    func fetchWeatherIcon(iconString: String , completion: @escaping (Data) -> Void) {
        usecase.fetchWeatherIcon(iconString: iconString, completion: completion)
    }
}
