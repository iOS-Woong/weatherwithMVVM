//
//  ProcessWeatherUsecaseTests.swift
//  ProcessWeatherUsecaseTests
//
//  Created by 서현웅 on 2023/06/13.
//

import XCTest
@testable import Weather

final class ProcessWeatherUsecaseTests: XCTestCase {

    var sut: ProcessWeatherUsecase!
    
    override func setUpWithError() throws {
        sut = ProcessWeatherUsecase()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_fetchFiveDaysForecast_호출시_Forecast를_27개반환하는가() {
        let promise = expectation(description: "Forecast count 27(UI에 보여줄 데이터수) Test")
        
        sut.fetchFiveDaysForecast {
            XCTAssertEqual( $0.count, 27)
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 10)
    }
    
    func test_fetchAllCitiesCurrentWeather_호출시_CityWeather를_8개반환하는가() {
        let promise = expectation(description: "CityWeather count 8(UI에 보여줄 데이터수) Test")
        
        sut.fetchAllCitiesCurrentWeather {
            XCTAssertEqual( $0.count, 8)
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 10)
    }
    
}
