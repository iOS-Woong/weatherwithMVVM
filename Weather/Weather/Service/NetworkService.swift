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
    private let repository = NetworkRepository()
    private let endPoint: EndPoint = EndPoint()
    
    
    func fetch<T: Decodable>(url: URL?,
                             type: T.Type,
                             completion: @escaping (Result<T, ProcessDataError>) -> Void) {
        repository.request(url: url) { result in
            switch result {
            case .success(let data):
                let processedData = decode(with: data, type: type.self)
                
                switch processedData {
                case .success(let decodedData):
                    completion(.success(decodedData))
                case .failure(_):
                    completion(.failure(ProcessDataError.decodeError))
                }
                                
            case .failure(let error):
                print("네트워크에러:", error)
                print(error.localizedDescription)
            }
        }
    }
    
    private func decode<T: Decodable>(with data: Data,
                                      type: T.Type) -> Result<T, ProcessDataError> {
        let jsonDecoder = JSONDecoder()
        
        do {
            let entity = try jsonDecoder.decode(type.self, from: data)
            return .success(entity)
        } catch {
            return .failure(.decodeError)
        }
    }
}

