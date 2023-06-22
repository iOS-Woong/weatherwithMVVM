//
//  ImageManagerTests.swift
//  ImageManagerTests
//
//  Created by 서현웅 on 2023/06/20.
//

import XCTest
@testable import Weather

final class ImageManagerTests: XCTestCase {

    var sut: ImageManager!
    var data: Data!
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_retriveImage_네트워크를통해서받아올때() {
        
        let networkManager = MockNetworkManager(data: data)
        let memoryCacheStorage =  MockMemoryCacheStorage()
        let diskStorage = MockDiskStorage()
        
        sut = ImageManager(networkManager: networkManager,
                           memoryCacheStorage: memoryCacheStorage,
                           diskStorage: diskStorage)
        
        
    }
}
