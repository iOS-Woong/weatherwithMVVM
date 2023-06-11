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
    
    // MARK: CurrentWeatherDataAPI HealthCheck
    
    func test_CurrentWeatherDataAPI_HealthCheck_하나의_도시대상() {
        // promise
        let url = endPoint.url(city: .seoul, for: .weather)!
        let promise = expectation(description: "[API: Current Weather] HealthCheck!")
        
        // when
        let task = sut.dataTask(with: url) { _, response, _ in
            guard let response = response as? HTTPURLResponse else {
                return
            }
            // then
            let statusCode = response.statusCode
            XCTAssertEqual(statusCode, 200)
            promise.fulfill()
        }
        task.resume()
        
        wait(for: [promise], timeout: 10)
    }

    func test_FiveDayWeatherForecast_HealthCheck() {
        
    }
    
    
}
