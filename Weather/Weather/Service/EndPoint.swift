//
//  EndPoint.swift
//  Weather
//
//  Created by 서현웅 on 2023/05/24.
//

import Foundation

enum Scheme: String {
    case https = "https"
}

enum Host: String {
    case base = "api.openweathermap.org"
}

enum Path: String {
    case base = "/data/2.5/weather"
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
            URLQueryItem(name: "appid", value: "44aea5632c5f4c27d89bbe765acbed69")
        ]
        
        return queryItems
    }
}

enum key: String {
    case key = "&appid=44aea5632c5f4c27d89bbe765acbed69"
    
}

struct EndPoint {
    func url(city query: QueryItem) -> URL? {
        var component = URLComponents()
        component.scheme = Scheme.https.rawValue
        component.host = Host.base.rawValue
        component.path = Path.base.rawValue
        component.queryItems = query.description
        return component.url
    }
}
