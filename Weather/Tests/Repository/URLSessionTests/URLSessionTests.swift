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
        // given
        let url = endPoint.url(city: .seoul, for: .weather)!
        let promise = expectation(description: "[API: Current Weather] 단수호출 HealthCheck!")
        
        // when
        let task = sut.dataTask(with: url) { _, response, _ in
            guard let response = response as? HTTPURLResponse else { return }
            // then
            let statusCode = response.statusCode
            XCTAssertEqual(statusCode, 200)
            promise.fulfill()
        }
        task.resume()
        
        wait(for: [promise], timeout: 10)
    }
    
    func test_CurrentWeatherDataAPI_HealthCheck_전체_도시대상_연쇄호출() {
        // given
        let allCityQueryItems : [QueryItem] = QueryItem.allCases // 8개 도시
        var allResponse = [Int]()
        let promise = expectation(description: "[API: Current Weather] 8개도시 연쇄호출 HealthCheck!")
        
        for city in allCityQueryItems {
            let url = self.endPoint.url(city: city, for: .weather)!
            
            let task = self.sut.dataTask(with: url) { _, response,  _ in
                guard let response = response as? HTTPURLResponse else { return }
                
                let statusCode = response.statusCode
                allResponse.append(statusCode)
                
                // then
                if allResponse.count == 8 {
                    promise.fulfill()
                    XCTAssertEqual(allResponse, [200, 200, 200, 200,    200, 200, 200, 200])
                }
            }
            task.resume()
        }
        wait(for: [promise], timeout: 10)
    }
    
    
    // MARK:  API: 5dayWeatherForecastAPI HealthCheck
    func test_FiveDayWeatherForecast_HealthCheck() {
        
    }
}
