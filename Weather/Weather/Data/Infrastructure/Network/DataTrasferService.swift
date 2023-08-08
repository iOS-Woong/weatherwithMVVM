//
//  DataTrasferService.swift
//  Weather
//
//  Created by 서현웅 on 2023/08/07.
//

import Foundation

enum ProcessDataError: Error {
    case decodeError(query: URL? = nil)
    case networkError(NetworkError)
}

final class DefaultDataTransferService {
    private let networkService = NetworkService()
}

extension DefaultDataTransferService {
    func request<T: Decodable>(
        _ endPoint: TargetType,
        type: T.Type,
        completion: @escaping (Result<T, ProcessDataError>) -> Void)
    {
        networkService.request(url: endPoint.url) { [weak self] result in
            switch result {
            case .success(let data):
                guard let self else { return }
                let decodedData = self.decode(with: data, type: type.self)
                completion(decodedData)
            case .failure(let error):
                completion(.failure(.networkError(error)))
            }
        }
    }
    
    private func decode<T: Decodable>(with data: Data, type: T.Type) -> Result<T, ProcessDataError> {
        do {
            let entity = try JSONDecoder().decode(type.self, from: data)
            return .success(entity)
        } catch {
            return .failure(.decodeError())
        }
    }
}
