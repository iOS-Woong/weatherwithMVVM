//
//  NetworkLoaderType.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/23.
//

import Foundation

protocol NetworkLoaderType {
    func request(url: URL?, completion: @escaping (Result<Data, NetworkError>) -> Void)
}
