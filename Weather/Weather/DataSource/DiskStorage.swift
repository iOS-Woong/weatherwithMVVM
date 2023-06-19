//
//  DiskStorage.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/17.
//

import Foundation

enum DiskStorageError: Error {
    case canNotFoundDocumentDirectory
    case canNotCreateStorageDirectory(path: String)
    case storeError(path: String)
    case removeError(path: String)
    case canNotLoadFileList(path: String)
}

class DiskStorage {
    private let fileManager: FileManager
    private let directory: URL
    
    
    init(fileManager: FileManager = FileManager.default, directoryName: String) throws {
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { throw DiskStorageError.canNotFoundDocumentDirectory }
        self.fileManager = fileManager
        self.directory = documentDirectory.appendingPathComponent(directoryName)
        try createDirectory(with: self.directory)
    }
    
    
    private func createDirectory(with url: URL) throws {
        guard !fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            try fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        } catch {
            throw DiskStorageError.canNotCreateStorageDirectory(path: url.path)
        }
    }
}
