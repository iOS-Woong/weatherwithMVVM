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
// 01d
// https://api.openweathermap.org/img/wn/{image Name}@2x.png
enum Scheme: String {
    case https = "https"
}

enum Host: String {
    case base = "api.openweathermap.org"
    case sub = "openweathermap.org"
}

enum Path: String {
    case weather = "/data/2.5/weather"
    case forecast = "/data/2.5/forecast"
    case icon = "/img/wn"
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
}
