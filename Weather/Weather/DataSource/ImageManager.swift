//
//  ImageManager.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/19.
//

import Foundation

class ImageManager {
    private let memoryCacheStorage: MemoryCacheStorage<Data>
    private let diskStorage: DiskStorage
    
    init(memoryCacheStorage: MemoryCacheStorage<Data>, diskStorage: DiskStorage) {
        self.memoryCacheStorage = memoryCacheStorage
        self.diskStorage = diskStorage
    }
    
    func retriveImage(_ url: String, completion: @escaping (Result<Data?, Error>) -> Void) {
        if let data = memoryCacheStorage.object(url) {
            completion(.success(data))
        } else if diskStorage.isStored(for: url) == true {
            let data = diskStorage.object(url)
            
            completion(.success(data))
            memoryCacheStorage.insert(data, for: url)
        } else {
            return
        }
    }
    
    private func loadImage(url: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        
        
        
    }
    
}
