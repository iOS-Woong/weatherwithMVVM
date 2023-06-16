//
//  WeatherViewModelTests.swift
//  WeatherViewModelTests
//
//  Created by 서현웅 on 2023/06/14.
//

import XCTest
@testable import Weather

final class WeatherViewModelTests: XCTestCase {

    var sut: WeatherViewModel!
    
    override func setUpWithError() throws {
        sut = WeatherViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_fetch함수_호출하면_값을_정상적으로받아오는지() {
        // given
        var testForecasts: [Forecast]?
        var testCityWeathers: [CityWeather]?
        let promise = expectation(description: "Fetch 함수 테스트")
        promise.expectedFulfillmentCount = 2

        // bind
        sut.forecasts.subscribe {
            testForecasts = $0
            promise.fulfill()
        }
        
        sut.weathers.subscribe {
            testCityWeathers = $0
            promise.fulfill()
        }
        
        // when
        sut.fetch()
        
        // then
        XCTAssertNotNil(testForecasts)
        XCTAssertNotNil(testCityWeathers)
        
        wait(for: [promise], timeout: 10)
    }

}
