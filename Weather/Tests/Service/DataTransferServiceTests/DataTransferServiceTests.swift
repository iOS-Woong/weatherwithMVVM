//
//  DataTransferServiceTests.swift
//  DataTransferServiceTests
//
//  Created by 서현웅 on 2023/06/13.
//

import XCTest
@testable import Weather

final class DataTransferServiceTests: XCTestCase {

    var sut: DataTransferService!
    
    override func setUpWithError() throws {
        sut = DataTransferService()
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
}
