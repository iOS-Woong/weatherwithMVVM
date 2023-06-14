//
//  MainViewModel.swift
//  Weather
//
//  Created by 서현웅 on 2023/05/25.
//

import Foundation

class WeatherViewModel {
    private let usecase = ProcessWeatherUsecase()
    
    var forecasts: Observable<[Forecast]> = .init([Forecast(dt: "", temp: 0, icon: "")])
    var weathers: Observable<[CityWeather]> = .init([CityWeather(coordinate: Coordinate(lon: 0, lat: 0),
                                                                  temparature: Temparature(temp: 0, tempMin: 0, tempMax: 0),
                                                                  description: "",
                                                                  wind: WindInfo(speed: 0, deg: 0))])
    
}

extension WeatherViewModel {
    func fetch() {
        usecase.fetchAllCitiesCurrentWeather { self.weathers.value = $0 }
        usecase.fetchFiveDaysForecast { self.forecasts.value = $0 }
    }
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
