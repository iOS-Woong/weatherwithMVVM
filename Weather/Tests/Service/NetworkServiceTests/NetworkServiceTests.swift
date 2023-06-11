//
//  NetworkServiceTests.swift
//  NetworkServiceTests
//
//  Created by 서현웅 on 2023/06/12.
//

import XCTest
@testable import Weather


final class NetworkServiceTests: XCTestCase {

    var sut: NetworkService!
    let endPoint = EndPoint()
    
    override func setUpWithError() throws {
        sut = NetworkService()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    // MARK: fetch 함수 Test: [FiveDayWeatherForecast 타입의 데이터 process]
    
    func test_fetch_서울을_fetch했을때_cityName을_String으로_가져오는가() {
        let url = endPoint.url(city: .seoul, for: .forecast)!
        let seoulString = "seoul"
                
        sut.fetch(url: url, type: FiveDayWeatherForecast.self) { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.city.name, seoulString)
            case .failure(let error):
                XCTFail("\(error)")
            }
        }
    }
}
