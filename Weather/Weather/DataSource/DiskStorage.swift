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
    case canNotLoadFile(path: String)
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
    
    func isStored(for key: String) -> Bool {
        let filePath = directory.appendingPathComponent(key)
        
        return fileManager.fileExists(atPath: filePath.path)
    }
    
    func insert(_ object: Data, for key: String) {
        let filePath = directory.appendingPathComponent(key)
        
        fileManager.createFile(atPath: filePath.path, contents: object)
    }
    
    func object(_ key: String) throws -> Data? {
        let filePath = directory.appendingPathComponent(key)
        
        var loadObject: Data?
        
        do {
            loadObject = try Data(contentsOf: filePath)
        } catch {
            throw DiskStorageError.canNotLoadFile(path: filePath.path)
        }
        
        return loadObject
    }
    
    func remove(_ key: String) throws {
        let filePath = directory.appendingPathComponent(key)
        
        do {
            try fileManager.removeItem(at: filePath)
        } catch {
            throw DiskStorageError.removeError(path: filePath.path)
        }
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
