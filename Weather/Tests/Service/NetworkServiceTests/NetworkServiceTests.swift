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
    // 테스트범위: [서울-O]

    func test_fetch_서울을_fetch했을때_FiveDayWeatherForecast타입의_cityName을_seoul로_가져오는가() {
        let url = endPoint.url(city: .seoul, for: .forecast)!
        let seoulString = "Seoul"
        let promise = expectation(description: "[fetch & Precess Test]")
        
        sut.fetch(url: url, type: FiveDayWeatherForecast.self) { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.city.name, seoulString)
                promise.fulfill()
            case .failure(let error):
                XCTFail("\(error)")
            }
        }
        
        wait(for: [promise], timeout: 10)
    }
    
    // MARK: fetch 함수 Test: [CurrentWeather 타입의 데이터 process]
    // 테스트범위: [서울 / 부산 / 인천 / 대구 / 대전 / 광주 / 울산 / 세종 ] 8개도시
    // 1차: [전체도시-decodeError]
    // 2차: [서울-O / 부산-O / 인천-O / 대구-O / 대전-O / 광주-X / 울산-X / 세종-O]
    
    func test_fetch_서울을_fetch했을때_CurrentWeather타입의_name을_seoul로_가져오는가() {
        let url = endPoint.url(city: .sejong, for: .weather)!
        let promise = expectation(description: "[fetch & Precess Test]")
        
        sut.fetch(url: url, type: CurrentWeather.self) { result in
            switch result {
            case .success(let data):
                print("부산나와야하는데?", data.name)
                XCTAssertEqual(data.name, "Busan")
                promise.fulfill()
            case .failure(let error):
                XCTFail("\(error)")
            }
        }
        
        wait(for: [promise], timeout: 10)
    }
    
    func test_fetch_전체도시를_연속으로_fetch했을때_CurrentWeather타입의_name을_전부_가져오는가() {
        var allCityName = Set<[String]>()
        let promise = expectation(description: "전체도시 연쇄호출 및 데이터가공 테스트")
        
        for city in QueryItem.allCases {
            let url = endPoint.url(city: city, for: .weather)!
            
            sut.fetch(url: url, type: CurrentWeather.self) { result in
                switch result {
                case .success(let data):
                    let cityName = data.name
                    allCityName.insert([cityName])
                    
                    if allCityName.count == 8 {
                        
                        let setAllCity = Set(arrayLiteral: QueryItem.allCases.map { $0.rawValue })
                        XCTAssertEqual(allCityName, setAllCity.union(allCityName))
                        promise.fulfill()
                    }
                    
                case .failure(let error):
                    XCTFail("\(error)")
                }
            }
        }
        wait(for: [promise], timeout: 10)
    }
}
