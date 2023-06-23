//
//  ImageManager.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/19.
//

import Foundation

protocol ImageManagerType {
    func retriveImage(_ url: String,
                      completion: @escaping (Result<Data?, Error>) -> Void)
}

class ImageManager: ImageManagerType {
    private let memoryCacheStorage: MemoryCacheStorageType
    private let diskStorage: DiskStorageType?
    
    init(memoryCacheStorage: MemoryCacheStorageType = MemoryCacheStorage(),
         diskStorage: DiskStorageType = try! DiskStorage(directoryName: "mainDirectory")) {
        self.memoryCacheStorage = memoryCacheStorage
        self.diskStorage = diskStorage
    }
    
    func retriveImage(_ url: String,
                      completion: @escaping (Result<Data?, Error>) -> Void) {
        if let data = memoryCacheStorage.object(url) {
            completion(.success(data))
        } else if diskStorage?.isStored(for: url) == true {
            let data = diskStorage?.object(url)
            memoryCacheStorage.insert(data!, for: url)
            completion(.success(data))
        } else {
            return
//            loadImage(url: url) { result in
//                switch result {
//                case .success(let data):
//                    completion(.success(data))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
        }
    }
    
//    private func loadImage(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
//        let requestUrl = URL(string: url)
//        networkManager.request(url: requestUrl) { result in
//            switch result {
//            case .success(let data):
//                completion(.success(data))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
}
