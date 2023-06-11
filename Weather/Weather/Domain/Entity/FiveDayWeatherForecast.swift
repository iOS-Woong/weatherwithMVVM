//
//  FiveDayWeatherForecast.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/12.
//

import Foundation

/*
 API: 5 day weather forecast
 https://openweathermap.org/forecast5
 */

struct FiveDayWeatherForecast: Codable {
    let cod: String
    let message, cnt: Int
    let list: [FList]
    let city: FCity
}

// MARK: - City
struct FCity: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - Coord
struct FCoord: Codable {
    let lat, lon: Double
}

// MARK: - List
struct FList: Codable {
    let dt: Int
    let main: Main
    let weather: [FWeather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let rain: Rain?
    let sys: Sys
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, rain, sys
        case dtTxt = "dt_txt"
    }
}

// MARK: - Clouds
struct FClouds: Codable {
    let all: Int
}

// MARK: - Main
struct FMain: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
struct FRain: Codable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct FSys: Codable {
    let pod: String
}

// MARK: - Weather
struct FWeather: Codable {
    let id: Int
    let main, description, icon: String
}

// MARK: - Wind
struct FWind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}
