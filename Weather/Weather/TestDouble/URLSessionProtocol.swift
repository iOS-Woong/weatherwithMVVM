//
//  URLSessionProtocol.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/02.
//

import Foundation

typealias DataTaskCompletionHandler = (Data?, URLResponse?, Error?) -> Void

protocol URLSessionProtocol {
    func dataTask(with url: URL,
                  completionHandler: @escaping DataTaskCompletionHandler) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }
