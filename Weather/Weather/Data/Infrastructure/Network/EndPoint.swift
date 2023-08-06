//
//  EndPoint.swift
//  Weather
//
//  Created by 서현웅 on 2023/05/24.
//

import Foundation

// currentWather: https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
// 5dayweather: https://api.openweathermap.org/data/2.5/forecast?q={city name}&appid={API key}
// ImageData: https://api.openweathermap.org/img/wn/{image Name}@2x.png
// map: https://tile.openweathermap.org/map/temp/0/0/0.png?appid=44aea5632c5f4c27d89bbe765acbed69

enum Scheme: String {
    case https = "https"
}

enum Host: String {
    case base = "api.openweathermap.org"
    case sub = "openweathermap.org"
    case map = "tile.openweathermap.org"
}

enum Path: String {
    case weather = "/data/2.5/weather"
    case forecast = "/data/2.5/forecast"
    case icon = "/img/wn"
    case map = "/map/temp/0/0/0.png"
}

enum QueryItem: String, CaseIterable {
    case seoul = "seoul"
    case busan = "busan"
    case incheon = "incheon"
    case daegu = "daegu"
    case daejeon = "daejeon"
    case gwhangju = "gwangju"
    case ulsan = "ulsan"
    case sejong = "sejong"
    
    var description: [URLQueryItem] {
        let queryItems = [
            URLQueryItem(name: "q", value: self.rawValue),
            URLQueryItem(name: "appid", value: "44aea5632c5f4c27d89bbe765acbed69"),
            URLQueryItem(name: "lang", value: "kr")
        ]
        
        return queryItems
    }
    
    var cityNameKr: String {
        switch self {
        case .seoul:
            return "서울"
        case .busan:
            return "부산"
        case .incheon:
            return "인천"
        case .daegu:
            return "대구"
        case .daejeon:
            return "대전"
        case .gwhangju:
            return "광주"
        case .ulsan:
            return "울산"
        case .sejong:
            return "세종"
        }
    }
    
}

struct EndPoint {
    func url(city query: QueryItem?, for pathKind: Path) -> URL? {
        var component = URLComponents()
        component.scheme = Scheme.https.rawValue
        component.host = Host.base.rawValue
        component.path = pathKind.rawValue
        component.queryItems = query?.description
        return component.url
    }
    
    func imageUrl(icon name: String) -> URL? {
        var component = URLComponents()
        component.scheme = Scheme.https.rawValue
        component.host = Host.sub.rawValue
        component.path = Path.icon.rawValue
        component.path.append("/\(name)@2x.png")
        return component.url
    }
    
    func tempMapUrl() -> URL? {
        var component = URLComponents()
        component.scheme = Scheme.https.rawValue
        component.host = Host.map.rawValue
        component.path = Path.map.rawValue
        component.query = "appid=44aea5632c5f4c27d89bbe765acbed69"
        return component.url
    }
}
