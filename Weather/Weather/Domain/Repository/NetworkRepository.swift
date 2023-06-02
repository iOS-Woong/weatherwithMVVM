//
//  Repository.swift
//  Weather
//
//  Created by 서현웅 on 2023/05/24.
//

import Foundation

struct NetworkRepository {
    private let endPoint: EndPoint = EndPoint()
    
    func fetch(query: QueryItem, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = endPoint.url(city: query) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.requestError))
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard (200..<300) ~= response.statusCode else {
                completion(.failure(.responseError(code: response.statusCode, data: data)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            completion(.success(data))
            
        }.resume()
    }
    
}
