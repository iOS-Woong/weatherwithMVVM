//
//  ObservableTests.swift
//  ObservableTests
//
//  Created by 서현웅 on 2023/06/14.
//

import XCTest
@testable import Weather

final class ObservableTests: XCTestCase {
    var sut: Observable<String>!
    
    func test_value가_변경되었을때_listner클로저가_호출되는지() {
        // given
        let test = "Observable 객체의 테스트"
        let sut: Observable<String> = Observable(test)

        // when
        var observedValue: String?
        
        sut.subscribe { observedValue = $0 }
        sut.value = "저는 변경되었어요"
        
        // then
        XCTAssertEqual(observedValue, "저는 변경되었어요")
    }
}
