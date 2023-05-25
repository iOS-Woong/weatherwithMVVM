//
//  NetworkService.swift
//  Weather
//
//  Created by 서현웅 on 2023/05/24.
//

import Foundation

struct NetworkService {
    private let repository = Repository()
    
    private var queryCities: [QueryItem] {
        return QueryItem.allCases.map { $0 }
    }
    
    func fetch() {
        for city in queryCities {
            repository.fetch(query: city) { result in
                switch result {
                case .success(let data):
                    guard let data = data else {
                        return
                        
                    }
                    let currentWeather = decode(with: data)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func decode(with data: Data) -> Result<CurrentWeather, Error> {
        let jsonDecoder = JSONDecoder()
        
        do {
            let entity = try jsonDecoder.decode(CurrentWeather.self, from: data)
            return .success(entity)
        } catch {
            return .failure(<#T##Error#>)
        }
    }
}

enum ProcessDataError {
    case
}

