//
//  MockDiskStorage.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/23.
//

@testable import Weather
import XCTest

class MockDiskStorage: DiskStorageType {
    let fileName: StaticString = "MockDiskStorage.swift"
    
    private var storage: [String:Data] = [:]
    
    private var isStoreKey: String?
    private var isStoreCallCount: Int = 0

    private var storeValue: Data?
    private var storeKey: String?
    private var storeCallCount: Int = 0
    
    private var objectKey: String?
    private var objectCallCount: Int = 0
    
    private var removeKey: String?
    private var removeCallCount: Int = 0
        
    func isStored(for key: String) -> Bool {
        isStoreKey = key
        isStoreCallCount += 1
        return storage[key] != nil
    }
    
    func insert(_ object: Data, for key: String) {
        storeValue = object
        storeKey = key
        storeCallCount += 1
        storage[key] = object
    }
    
    func object(_ key: String) -> Data? {
        objectKey = key
        objectCallCount += 1
        return storage[key]
    }
    
    func remove(_ key: String) throws {
        removeKey = key
        removeCallCount += 1
        storage[key] = nil
    }
    
    func verifyIsStore(key: String, callCount: Int = 1) {
        XCTAssertEqual(isStoreKey, key, file: fileName)
        XCTAssertEqual(isStoreCallCount, callCount, file: fileName)
    }
    
    func verifyObject(key: String, callCount: Int = 1) {
        XCTAssertEqual(objectKey, key, file: fileName)
        XCTAssertEqual(objectCallCount, callCount, file: fileName)
    }
}
