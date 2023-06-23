//
//  MockMemoryCacheStorage.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/23.
//

@testable import Weather
import XCTest

class MockMemoryCacheStorage: MemoryCacheStorageType {
    private let fileName: StaticString = "MockMemoryCacheStorage.swift"
    
    private var storage: [String: Data] = [:]
    
    private var insertKey: String?
    private var insertValue: Data?
    private var insertCallCount: Int = 0
    
    private var objectKey: String?
    private var objectCallCount: Int = 0
    
    func insert(_ object: Data, for key: String) {
        insertKey = key
        insertValue = object
        insertCallCount += 1
        storage[key] = object
    }
    
    func object(_ key: String) -> Data? {
        objectKey = key
        objectCallCount += 1
        
        return storage[key]
    }
    
    func verifyObject(key: String, callCount: Int = 1) {
        XCTAssertEqual(objectKey, key, file: fileName)
        XCTAssertEqual(objectCallCount, callCount, file: fileName)
    }
    
    func verifyInsert(object: Data, key: String, callCount: Int = 1) {
        XCTAssertEqual(key, insertKey, file: fileName)
        XCTAssertEqual(object, insertValue, file: fileName)
        XCTAssertEqual(insertCallCount, callCount, file: fileName)
    }
    
}
