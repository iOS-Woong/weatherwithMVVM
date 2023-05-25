//
//  NetworkService.swift
//  Weather
//
//  Created by 서현웅 on 2023/05/24.
//

import Foundation

enum ProcessDataError: Error {
    case decodeError
}

struct NetworkService {
    private let repository = Repository()
    
    private var queryCities: [QueryItem] {
        return QueryItem.allCases.map { $0 }
    }
    
    func fetch<T: Decodable>(type: T.Type,
                             completion: @escaping (Result<T, ProcessDataError>) -> Void) {
        for city in queryCities {
            repository.fetch(query: city) { result in
                switch result {
                case .success(let data):
                    let currentWeather = decode(with: data, type: T.self)
                    completion(currentWeather)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func decode<T: Decodable>(with data: Data, type: T.Type) -> Result<T, ProcessDataError> {
        let jsonDecoder = JSONDecoder()
        
        do {
            let entity = try jsonDecoder.decode(type.self, from: data)
            return .success(entity)
        } catch {
            return .failure(.decodeError)
        }
    }
}

