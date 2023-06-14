//
//  StubURLSession.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/02.
//

import Foundation

struct DummyData {
    let data: Data?
    let response: URLResponse?
    let error: Error?
    var completionHandler: DataTaskCompletionHandler? = nil
    
    func completion() {
        completionHandler?(data, response, error)
    }
}

class StubURLSession: URLSessionProtocol {
    let dummyData: DummyData?
    
    init(dummyData: DummyData? = nil) {
        self.dummyData = dummyData
    }
    
    
    func dataTask(with url: URL,
                  completionHandler: @escaping DataTaskCompletionHandler) -> URLSessionDataTask {
        return StubURLSessionDataTask(dummyData: dummyData, completionHandler: completionHandler)
    }
}

class StubURLSessionDataTask: URLSessionDataTask {
    var dummyData: DummyData?
    
    init(dummyData: DummyData?, completionHandler: DataTaskCompletionHandler?) {
        self.dummyData = dummyData
        self.dummyData?.completionHandler = completionHandler
    }
    
    override func resume() {
        dummyData?.completion()
    }
}
