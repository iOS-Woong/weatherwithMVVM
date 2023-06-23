//
//  MemoryCacheStorageTests.swift
//  MemoryCacheStorageTests
//
//  Created by 서현웅 on 2023/06/17.
//

import XCTest
@testable import Weather

final class MemoryCacheStorageTests: XCTestCase {
    
    var sut: MemoryCacheStorage!
    
    override func setUpWithError() throws {
        sut = MemoryCacheStorage()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_cache메모리에_setObject하고_object로_꺼내오면_두값은_동일할지() {
        // given
        let key: String = "1"
        let object: Data = createJsonMock(key: key, stringObject: "firstObject")
        
        // when
        sut.insert(object, for: key)
        
        // then
        let result = sut.object(key)
        
        XCTAssertEqual(result, object)
    }
    
    func test_cache메모리에_5개를_setObject하고_object를_5회하면_두값은_동일할지() {
        // given
        let keys = ["1", "2", "3", "4", "5"]
        let datas = [
            createJsonMock(key: keys[0], stringObject: "zero"),
            createJsonMock(key: keys[1], stringObject: "first"),
            createJsonMock(key: keys[2], stringObject: "second"),
            createJsonMock(key: keys[3], stringObject: "third"),
            createJsonMock(key: keys[4], stringObject: "fourth")
        ]
        
        // when
        for (index, data) in datas.enumerated() {
            sut.insert(data, for: keys[index])
        }
        
        // then
        var result = [Data]()
        
        for key in keys {
            result.append(sut.object(key)!)
        }
        
        XCTAssertEqual(result, datas)
    }
    
    private func createJsonMock(key: String, stringObject: String) -> Data {
        let mockDictionary = ["\(key)": "\(stringObject)"]
        return try! JSONSerialization.data(withJSONObject: mockDictionary)
    }
}
