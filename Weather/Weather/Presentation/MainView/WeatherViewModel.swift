//
//  MainViewModel.swift
//  Weather
//
//  Created by 서현웅 on 2023/05/25.
//

import Foundation

class MainViewModel {
    private let service = NetworkService()
    
    
    
}


// Test함수
extension MainViewModel {
    func testUUIDs(count: Int) -> [UUID] {
        var uuids = [UUID]()
        let index = count - 1
        
        for _ in 0...index {
            let uuid = UUID()
            uuids.append(uuid)
        }
        return uuids
    }
}
