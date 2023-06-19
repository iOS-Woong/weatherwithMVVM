//
    //  DiskStorageError+Equatable.swift
//  DiskStorageTests
//
//  Created by 서현웅 on 2023/06/19.
//

@testable import Weather

extension DiskStorageError: Equatable {
    public static func == (lhs: DiskStorageError, rhs: DiskStorageError) -> Bool {
        switch (lhs, rhs) {
            
        case (.canNotFoundDocumentDirectory, .canNotFoundDocumentDirectory):
            return true
        case let (.canNotCreateStorageDirectory(path: lhsCode), .canNotCreateStorageDirectory(path: rhsCode)):
            return lhsCode == rhsCode
        case let (.storeError(path: lhsCode), .storeError(path: rhsCode)):
            return lhsCode == rhsCode
        case let (.removeError(path: lhsCode), .removeError(path: rhsCode)):
            return lhsCode == rhsCode
        case let (.canNotLoadFile(path: lhsCode), .canNotLoadFile(path: rhsCode)):
            return lhsCode == rhsCode
        default :
            return false
        }
    }
}
