//
//  MemoryCacheStorage.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/17.
//

import UIKit

class MemoryObject<T> {
    let value: T
    
    init(value: T) {
        self.value = value
    }
}


class MemoryCacheStorage<T> {
    typealias MemoryType = NSCache<NSString, MemoryObject<T>>
    
    private let cache = MemoryType()
}

extension MemoryCacheStorage {
    func insert(_ object: T, for key: String) {
        let memoryObject = MemoryObject(value: object)
        
        cache.setObject(memoryObject, forKey: key as NSString)
    }
    
    func object(_ key: String) -> T? {
        guard let memoryObject = cache.object(forKey: key as NSString) else { return nil }
        
        return memoryObject.value
    }    
}
