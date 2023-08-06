//
//  FiveDayWeatherForecast.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/12.
//

import Foundation

struct ForecastDTO: Decodable {
    let cod: String
    let message, cnt: Int
    let list: [FList]
    let city: FCity
}

extension ForecastDTO {
    struct FList: Decodable {
        let dt: Int
        let main: Main
        let weather: [Weather]
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
    
    struct FCity: Decodable {
        let id: Int
        let name: String
        let coord: Coord
        let country: String
        let population, timezone, sunrise, sunset: Int
    }
}

extension ForecastDTO.FList {
    struct Main: Decodable {
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
    
    struct Weather: Decodable {
        let id: Int
        let main, description, icon: String
    }
    
    struct Clouds: Decodable {
        let all: Int
    }

    struct Wind: Decodable {
        let speed: Double
        let deg: Int
        let gust: Double
    }
    
    struct Rain: Decodable {
        let the3H: Double

        enum CodingKeys: String, CodingKey {
            case the3H = "3h"
        }
    }

    struct Sys: Decodable {
        let pod: String
    }
}

extension ForecastDTO.FCity {
    struct Coord: Decodable {
        let lat, lon: Double
    }
}
