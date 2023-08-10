//
//  DefaultNetworkRepository.swift
//  Weather
//
//  Created by 서현웅 on 2023/05/24.
//

import Foundation

final class CityUnitRepository {
    private let dataTransferService = DefaultDataTransferService()
}

extension CityUnitRepository {
    func requestCurrentCityWeather(
        city: City,
        completion: @escaping (Result<CityWeather, ProcessDataError>) -> Void)
    {
        let endPoint = EndPoint.forecast(city: city.rawValue)
        
        dataTransferService.request(endPoint, type: WeatherDTO.self) { result in
            switch result {
            case .success(let responseDTO):
                let cityWeather = responseDTO.mapToCityWeather()
                completion(.success(cityWeather))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}