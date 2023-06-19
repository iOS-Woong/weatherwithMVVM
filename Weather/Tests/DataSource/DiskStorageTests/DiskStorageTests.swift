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
    
    private func createJsonMock() -> Data {
        let mockDictionary = ["UIImage": "TestImage"]
        return try! JSONSerialization.data(withJSONObject: mockDictionary)
    }
}
