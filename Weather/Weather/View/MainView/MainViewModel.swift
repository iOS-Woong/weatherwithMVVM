//
//  MainViewModel.swift
//  Weather
//
//  Created by 서현웅 on 2023/05/25.
//

import Foundation

class MainViewModel {
    private let service = NetworkService()
    
    func fetchCurrentWeathers(entity: CurrentWeather.Type) {
        service.fetch(type: entity.self) { result in
            switch result {
            case .success(let entity):
                // TODO: cities Weather entity 처리
                print(entity)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}
