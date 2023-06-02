//
//  URLSessionTests.swift
//  URLSessionTests
//
//  Created by 서현웅 on 2023/06/02.
//

import XCTest
@testable import Weather

final class URLSessionTests: XCTestCase {

    var sut: URLSession!
    let endPoint = EndPoint()
    
    override func setUpWithError() throws {
        sut = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_서울URL요청시_상태코드200번이_들어오는지() {
        // given
        let url = endPoint.url(city: .seoul)!
        let promise = expectation(description: "Status Code 200")
        // when
        let task = sut.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                return
            }
            //then
            let statusCode = response.statusCode
            XCTAssertEqual(statusCode, 200)
            promise.fulfill()
        }
        task.resume()
        
        wait(for: [promise], timeout: 10)
    }
    
}
