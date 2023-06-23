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
    var testKeyUrl: String!
    
    override func setUpWithError() throws {
        data = UIImage(systemName: "cloud")?.pngData()
        testKeyUrl = "test"
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_retrieveImage_메모리캐시_object메서드_행동검증() {
        let promise = expectation(description: "forAsyncTests")
        defer { wait(for: [promise], timeout: 5) }
        
        let memoryCacheStorage = MockMemoryCacheStorage()
        memoryCacheStorage.insert(data, for: testKeyUrl)
        let diskStorage = MockDiskStorage()
        
        sut = ImageManager(memoryCacheStorage: memoryCacheStorage,
                           diskStorage: diskStorage)
        
        sut.retriveImage(testKeyUrl) { result in
            switch result {
            case .success(_):
                memoryCacheStorage.verifyObject(key: self.testKeyUrl)
                promise.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
    }
    
    func test_retriveImage_디스크_Isstore_Object메서드_메모리캐시_Insert메서드_행동검증() {
        let promise = expectation(description: "forAsyncTests")
        defer { wait(for: [promise], timeout: 5) }
        
        let memoryCacheStorage = MockMemoryCacheStorage()
        let diskStorage = MockDiskStorage()
        diskStorage.insert(data, for: testKeyUrl)
        
        sut = ImageManager(memoryCacheStorage: memoryCacheStorage,
                           diskStorage: diskStorage)
        
        sut.retriveImage(testKeyUrl) { result in
            switch result {
            case .success(let data):
                diskStorage.verifyIsStore(key: self.testKeyUrl)
                diskStorage.verifyObject(key: self.testKeyUrl)
                memoryCacheStorage.verifyInsert(object: data!, key: self.testKeyUrl)
                promise.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
    }
}
