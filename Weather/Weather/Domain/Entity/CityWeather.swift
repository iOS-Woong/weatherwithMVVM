//
//  CityWeather.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/14.
//

import Foundation

struct CityWeather: Hashable { // TODO: 필요한 프로퍼티가 더 있다면 추가해야함.
    let id = UUID()
    let name: String
    let icon: String
    let coordinate: Coordinate
    let temparature: Temparature
    let description: String
    let wind: WindInfo
}

struct Coordinate: Hashable {
    let lon: Double
    let lat: Double
}

struct Temparature: Hashable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
}

struct WindInfo: Hashable {
    let speed: Double
    let deg: Int
}
