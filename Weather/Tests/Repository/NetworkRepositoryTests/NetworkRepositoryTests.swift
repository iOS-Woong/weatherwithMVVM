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

    func test_name으로_Seoul을_받았을때() {
        
    }
    
}
