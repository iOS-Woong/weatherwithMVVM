//
//  MockMemoryCacheStorage.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/23.
//

@testable import Weather
import XCTest

class MockMemoryCacheStorage: MemoryCacheStorageType {
    
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
    }
    
    func object(_ key: String) -> Data? {
        objectKey = key
        objectCallCount += 1
        
        return storage[key]
    }
    
    
}
