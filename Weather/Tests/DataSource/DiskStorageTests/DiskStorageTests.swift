//
//  DiskStorageTests.swift
//  DiskStorageTests
//
//  Created by 서현웅 on 2023/06/19.
//

import XCTest
@testable import Weather

final class DiskStorageTests: XCTestCase {
    
    var sut: DiskStorage!
    var fileManager = FileManager.default
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    // MARK: Init
    
    func test_diskStorage_init했을때_의도한URL에_Directory가_생성되었는지() {
        // given
        let directoryName = "ForTestDirectory_First"
        
        // when
        sut = try! DiskStorage(directoryName: directoryName)
        
        // then
        guard let url = fileManager.urls(for: .documentDirectory,
                                         in: .userDomainMask).first else { return }
        let directory = url.appendingPathComponent(directoryName)
        print(directory.path)
        let result = fileManager.fileExists(atPath: directory.path)
        
        XCTAssertTrue(result)
    }
    
    // MARK: Create
    
    func test_diskStorage_insert했을때_Directory에_파일이생성되었는지() {
        // given
        let directoryName = "ForTestDirectory_Second"
        sut = try! DiskStorage(directoryName: directoryName)
        
        // when
        let mock = createJsonMock()
       
        sut.insert(mock, for: "FirstKey2")
       
                
        // then
        guard let url = fileManager.urls(for: .documentDirectory,
                                         in: .userDomainMask).first else { return }
        var directory = url.appendingPathComponent(directoryName)
        directory.appendPathComponent("FirstKey2")
        
        print(directory.path) // terminal에서 파일위치 open . 찍어보는용도 -- For macOS Simulator Only
        
        let result = fileManager.fileExists(atPath: directory.path)
        
        XCTAssertTrue(result)
    }
    
    // MARK: Read
    func test_diskStorage_isStored했을때_파일이있으면_True값을뱉는지() {
        // given
        let directoryName = "isStored"
        let keyName = "storedBoolCheck"
        
        sut = try! DiskStorage(directoryName: directoryName)
        let mock = createJsonMock()
        
        // when
        sut.insert(mock, for: keyName)

        // then
        let result = sut.isStored(for: keyName)
        
        XCTAssertTrue(result)
        
    }
    
    
    func test_diskStorage_object했을때_파일을가져오는지() {
        // given
        let directoryName = "ForTestDirectory_Third"
        let keyName = "key"
        
        sut = try! DiskStorage(directoryName: directoryName)
        let mock = createJsonMock()
        sut.insert(mock, for: keyName)

        // when
        let result = try! sut.object(keyName)
        
        // then
        XCTAssertEqual(result, mock)
    }
    
    func test_diskStorage_잘못된키값으로_object했을때_에러를뱉는지() {
        // given
        let directoryName = "ForTestDirectory_Fourth"
        let keyName = "key"
        let mismatchedKey = "mismatchedKey"
        
        sut = try! DiskStorage(directoryName: directoryName)
        let mock = createJsonMock()
        sut.insert(mock, for: keyName)

        // when
        
        guard let url = fileManager.urls(for: .documentDirectory,
                                         in: .userDomainMask).first else { return }
        let directory = url.appendingPathComponent(directoryName)
        let filePath = directory.appendingPathComponent(mismatchedKey)

        // then
        XCTAssertThrowsError(try sut.object(mismatchedKey)) { error in
            XCTAssertEqual(error as? DiskStorageError, DiskStorageError.canNotLoadFile(path: filePath.path))
        }
    }
    
    // MARK: Delete
    
    func test_diskStorage_remove했을때_파일을지우는지() {
        // given
        let directoryName = "ForTestDirectory_Fifth"
        let keyName = "key"
        // when
        sut = try! DiskStorage(directoryName: directoryName)
        let mock = createJsonMock()
        sut.insert(mock, for: keyName)
        try! sut.remove(keyName)
        
        
        // then
        guard let url = fileManager.urls(for: .documentDirectory,
                                         in: .userDomainMask).first else { return }
        let directory = url.appendingPathComponent(directoryName)
        let filePath = directory.appendingPathComponent(keyName)
        
        let result = fileManager.fileExists(atPath: filePath.path)

        XCTAssertFalse(result)
    }
    
    func test_diskStorage_잘못된키값으로_remove했을때_에러를뱉는지() {
        // given
        let directoryName = "ForTestDirectory_Sixth"
        let keyName = "Key"
        let mismatchedKey = "mismatchedKey"
        
        // when
        sut = try! DiskStorage(directoryName: directoryName)
        let mock = createJsonMock()
        try sut.insert(mock, for: keyName)
        
        
        guard let url = fileManager.urls(for: .documentDirectory,
                                         in: .userDomainMask).first else { return }
        let directory = url.appendingPathComponent(directoryName)
        let filePath = directory.appendingPathComponent(mismatchedKey)
        
        // then
        XCTAssertThrowsError(try sut.remove(mismatchedKey)) { error in
            XCTAssertEqual(DiskStorageError.removeError(path: filePath.path),
                           error as? DiskStorageError)
        }
    }
    
    private func createJsonMock() -> Data {
        let mockDictionary = ["UIImage": "TestImage"]
        return try! JSONSerialization.data(withJSONObject: mockDictionary)
    }
}


