//
//  FetchAllCitiesCurrentWeatherUsecase.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/14.
//

import Foundation

class fetchAllCitiesCurrentWeatherUsecase {
    /*
     func fetchAllCitiesCurrentWeather(completion: @escaping ([CityWeather]) -> Void) {
         let dispatchGroup = DispatchGroup()
         var citiesWeather: [CityWeather] = []
         
         for city in QueryItem.allCases {
             dispatchGroup.enter()
             let url = endPoint.url(city: city, for: .weather)
             service.fetch(url: url, type: CurrentWeatherRequestDTO.self) { result in
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
     */
}
