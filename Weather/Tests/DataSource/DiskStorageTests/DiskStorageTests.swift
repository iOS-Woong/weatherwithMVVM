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
        let directoryName = "ForTestDirectory"
        sut = try! DiskStorage(directoryName: directoryName)
        
        // when
        
        // then
        guard let url = fileManager.urls(for: .documentDirectory,
                                         in: .userDomainMask).first else { return }
        let directory = url.appendingPathComponent(directoryName)

        let result = fileManager.fileExists(atPath: directory.path)
        
        XCTAssertTrue(result)
    }
}
