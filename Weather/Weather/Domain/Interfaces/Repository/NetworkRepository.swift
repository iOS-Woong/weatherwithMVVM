//
//  Repository.swift
//  Weather
//
//  Created by 서현웅 on 2023/05/24.
//

import Foundation

struct NetworkRepository {
    var urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func request(url: URL?, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = url else {
            completion(.failure(.invalidURL))
            return
        }
                
        let task = urlSession.dataTask(with: url) { data, response, error in
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
            
        }
        task.resume()
    }
    
}
