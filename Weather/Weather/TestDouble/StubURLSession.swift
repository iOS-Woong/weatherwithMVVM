//
//  StubURLSession.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/02.
//

import Foundation

struct DummyData {
    let data: Data
    let response: URLResponse
    let error: Error
    let completionHandler: DataTaskCompletionHandler? = nil
    
    func completion() {
        completionHandler?(data, response, error)
    }
}
