//
//  NetworkError.swift
//  Weather
//
//  Created by 서현웅 on 2023/05/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL // 0
    case invalidResponse // 1
    case invalidData // 2
    case requestError // 3
    case responseError(code: Int, data: Data?) // 4
    case decodeError // 5
}
