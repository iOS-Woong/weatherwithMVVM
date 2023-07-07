//
//  CityWeather.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/14.
//

import Foundation

struct CityWeather: Hashable {
    let id = UUID()
    let weatherId: Int
    let name: String
    let icon: String
    let coordinate: Coordinate
    let temparature: Temparature
    let description: String
    let wind: WindInfo
    let cloud: Cloud
    let sun: Sun
}

struct Coordinate: Hashable {
    let lon: Double
    let lat: Double
}

struct Temparature: Hashable {
    let detail: DetailStuff
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let sensoryTemp: Double
}

struct DetailStuff: Hashable {
    let pressure: Int
    let humidity: Int
    let visibility: Int
}

struct WindInfo: Hashable {
    let speed: Double
    let deg: Int
}

struct Cloud: Hashable {
    let Cloudiness: Int
}

struct Sun: Hashable {
    let sunrise: Int
    let sunset: Int
}
