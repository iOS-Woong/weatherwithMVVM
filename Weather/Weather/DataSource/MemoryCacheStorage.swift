//
//  MemoryCacheStorage.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/17.
//

import UIKit

class MemoryCacheStorage {
    private let cache = NSCache<NSString, UIImage>()
}

extension MemoryCacheStorage {
    func insert(_ object: UIImage, for key: String) {
        cache.setObject(object, forKey: key as NSString)
    }
    
    func object(_ key: String) -> UIImage? {
        guard let cachedImage = cache.object(forKey: key as NSString) else { return nil }
        return cachedImage
    }    
}
