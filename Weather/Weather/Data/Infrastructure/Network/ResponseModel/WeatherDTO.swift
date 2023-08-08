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

// MARK: Mapping

extension WeatherDTO {
    func mapToCityWeather() -> CityWeather {
        let coordinate = Coordinate(lon: self.coord.lon, lat: self.coord.lat)
        let detailStuff = DetailStuff(
            pressure: self.main.pressure,
            humidity: self.main.humidity,
            visibility: self.visibility)
        
        let temparature = Temparature(
            detail: detailStuff,
            temp: self.main.temp,
            tempMin: self.main.tempMin,
            tempMax: self.main.tempMax,
            sensoryTemp: self.main.feelsLike)

        let windInfo = WindInfo(speed: self.wind.speed, deg: self.wind.deg)
        let cloud = Cloud(Cloudiness: self.clouds.all)
        let sun = Sun(sunrise: self.sys.sunrise, sunset: self.sys.sunset)
        
        return CityWeather(weatherId: self.weather.first?.id ?? 0,
                           name: self.name,
                           icon: self.weather.first?.icon ?? "",
                           coordinate: coordinate,
                           temparature: temparature,
                           description: self.weather.first?.description ?? "",
                           wind: windInfo,
                           cloud: cloud,
                           sun: sun)
    }
}
