//
//  Entity.swift
//  Weather
//
//  Created by 서현웅 on 2023/05/24.
//

import Foundation

struct CurrentWeather: Codable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let dt: Int //Time of data calculation, unix, UTC
    let timezone, id: Int
    let name: String
}

struct Main: Codable {
    let temp, tempMin, tempMax: Double
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case humidity
    }
}

struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

struct Wind: Codable {
    let speed: Double // Wind speed. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour.
    let deg: Int // 방향임. 각도로 계산되어 전달되는듯함 (이를, 남,서,동,북, 남서 등으로 해줘야함.
}
