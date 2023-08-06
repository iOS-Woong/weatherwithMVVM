//
//  Entity.swift
//  Weather
//
//  Created by 서현웅 on 2023/05/24.
//

/*
 API: Current weather data
 https://openweathermap.org/current
 */

import Foundation

struct WeatherDTO: Decodable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

extension WeatherDTO {
    struct Coord: Decodable {
        let lon, lat: Double
    }
    
    struct Weather: Decodable {
        let id: Int
        let main, description, icon: String
    }
    
    struct Main: Decodable {
        let temp, feelsLike, tempMin, tempMax: Double
        let pressure, humidity: Int
        
        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure, humidity
        }
    }
    
    struct Wind: Decodable {
        let speed: Double
        let deg: Int
    }
    
    struct Clouds: Decodable {
        let all: Int
    }
    
    struct Sys: Decodable {
        let country: String
        let sunrise, sunset: Int
    }
}
