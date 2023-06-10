//
//  MainViewModel.swift
//  Weather
//
//  Created by 서현웅 on 2023/05/25.
//

import Foundation

class MainViewModel {
    private let service = NetworkService()
    
    
    
    func testUUIDs() -> [UUID] {
        var uuids = [UUID]()

        for _ in 0...20 {
            let uuid = UUID()
            uuids.append(uuid)
        }
        return uuids
    }
    
    
}
