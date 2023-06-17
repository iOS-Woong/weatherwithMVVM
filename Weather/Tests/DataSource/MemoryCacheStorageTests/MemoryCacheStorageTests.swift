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
        let object: UIImage = UIImage(systemName: "cloud")!
        let key: String = "Cloud"
        
        // when
        sut.insert(object, for: key)
        
        // then
        let result = sut.object(key)
        
        XCTAssertEqual(result, object)
    }
    
    func test_cache메모리에_5개를_setObject하고_object를_5회하면_두값은_동일할지() {
        // given
        let keys = ["1", "2", "3", "4", "5"]
        let images = [
            UIImage(systemName: "cloud")!,
            UIImage(systemName: "pencil")!,
            UIImage(systemName: "pencil.line")!,
            UIImage(systemName: "eraser")!,
            UIImage(systemName: "scribble")!
        ]
        
        for (index, key) in keys.enumerated() {
            if index < images.count {
                let image = images[index]
                sut.insert(image, for: key)
            }
        }
        
        // when
        var resultImages = [UIImage]()
        
        for key in keys {
            guard let cached = sut.object(key) else { return }
            resultImages.append(cached)
        }
        
        // then
        XCTAssertEqual(resultImages, images)
    }
}
