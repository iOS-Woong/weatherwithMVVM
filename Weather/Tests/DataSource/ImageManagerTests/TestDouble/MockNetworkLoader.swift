//
//  MockNetworkLoader.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/23.
//

@testable import Weather
import XCTest

class MockNetworkLoader: NetworkLoaderType {
    let fileName: StaticString = "NetworkLoader.swift"
    
    private var requestUrl: URL?
    private var requestCallCount: Int = 0
    
    func request(url: URL?,
                 completion: @escaping (Result<Data, NetworkError>) -> Void) {
        requestUrl = url
        requestCallCount += 1
        completion(.success(Data()))
    }
    
    func verifyRequest(url: URL?, callCount: Int = 1) {
        XCTAssertEqual(requestUrl, url, file: fileName)
        XCTAssertEqual(requestCallCount, 1, file: fileName)
    }
}
