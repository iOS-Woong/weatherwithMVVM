//
//  NetworkError.swift
//  Weather
//
//  Created by 서현웅 on 2023/05/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case requestError
    case responseError(code: Int, data: Data?)
    case decodeError
}
