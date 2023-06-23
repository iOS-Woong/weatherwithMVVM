//
//  MemoryCacheStorage.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/17.
//

import UIKit

class MemoryObject {
    let value: Data
    
    init(value: Data) {
        self.value = value
    }
}

protocol MemoryCacheStorageType {
    func insert(_ object: Data, for key: String)
    func object(_ key: String) -> Data?
}

class MemoryCacheStorage: MemoryCacheStorageType {
    typealias MemoryType = NSCache<NSString, MemoryObject>
    
    private let cache = MemoryType()
    
    init() {
        cache.countLimit = .max
        cache.totalCostLimit = .zero
    }
}

extension MemoryCacheStorage {
    func insert(_ object: Data, for key: String) {
        let memoryObject = MemoryObject(value: object)
        
        cache.setObject(memoryObject, forKey: key as NSString)
    }
    
    func object(_ key: String) -> Data? {
        guard let memoryObject = cache.object(forKey: key as NSString) else { return nil }
        
        return memoryObject.value
    }
}
