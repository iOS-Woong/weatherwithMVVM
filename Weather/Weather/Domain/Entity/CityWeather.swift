//
//  CityWeather.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/14.
//

import Foundation

struct CityWeather { // TODO: 필요한 프로퍼티가 더 있다면 추가해야함.
    let coordinate: Coordinate
    let temparature: Temparature
    let description: String
    let wind: WindInfo
}

struct Coordinate {
    let lon: Double
    let lat: Double
}

struct Temparature {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
}

struct WindInfo {
    let speed: Double
    let deg: Int
}
