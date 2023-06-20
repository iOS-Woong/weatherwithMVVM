//
//  ImageManager.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/19.
//

import Foundation

class ImageManager {
    private let usecase: ProcessWeatherUsecase
    private let memoryCacheStorage: MemoryCacheStorage<Data>
    private let diskStorage: DiskStorage
    
    init(usecase: ProcessWeatherUsecase ,memoryCacheStorage: MemoryCacheStorage<Data>, diskStorage: DiskStorage) {
        self.usecase = usecase
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
            return loadImage(url: url) { result in
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func loadImage(url: String, completion: @escaping (Result<Data?, Error>) -> Void) {
        usecase.fetchWeatherIcon(iconString: url) { data in
            completion(.success(data))
        }
    }
}
