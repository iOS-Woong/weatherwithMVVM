//
//  FiveDayWeatherForecast.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/12.
//
/*
 API: 5 day weather forecast
 https://openweathermap.org/forecast5
 */

import Foundation

struct FiveDayWeatherForecast: Codable {
    let cod: String
    let message, cnt: Int
    let list: [FList]
    let city: FCity
}

struct FCity: Codable {
    let id: Int
    let name: String
    let coord: FCoord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

struct FCoord: Codable {
    let lat, lon: Double
}

struct FList: Codable {
    let dt: Int
    let main: FMain
    let weather: [FWeather]
    let clouds: FClouds
    let wind: FWind
    let visibility: Int
    let pop: Double
    let rain: FRain?
    let sys: FSys
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, rain, sys
        case dtTxt = "dt_txt"
    }
}

struct FClouds: Codable {
    let all: Int
}

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

struct FRain: Codable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

struct FSys: Codable {
    let pod: String
}

struct FWeather: Codable {
    let id: Int
    let main, description, icon: String
}

struct FWind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}
