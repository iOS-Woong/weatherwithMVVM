//
//  NetworkRepositoryTests.swift
//  NetworkRepositoryTests
//
//  Created by 서현웅 on 2023/06/02.
//

import XCTest
@testable import Weather

final class NetworkRepositoryTests: XCTestCase {

    var sut: NetworkRepository!
    
    override func setUpWithError() throws {
        sut = NetworkRepository()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_request로_요청했을때_응답이_stringDummy로_정상적으로_받아오는지() {
        // given
        let promise = expectation(description: "testDouble")
        let url = URL(string: "stubEndPoint")!
        let data = "stringDummy".data(using: .utf8)
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let dummy = DummyData(data: data, response: response, error: nil)
        let stubUrlSession = StubURLSession(dummyData: dummy)
        
        sut.urlSession = stubUrlSession
        
        // when
        sut.request(url: url) { result in
            switch result {
            case .success(let data):
                let stringData = String(data: data, encoding: .utf8)
                XCTAssertEqual(stringData, "stringDummy")
                promise.fulfill()
            case .failure(let networkError):
                XCTFail(networkError.localizedDescription)
            }
        }
        wait(for: [promise], timeout: 10)
    }
}
