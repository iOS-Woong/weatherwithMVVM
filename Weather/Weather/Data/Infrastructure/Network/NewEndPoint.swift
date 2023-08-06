//
//  NewEndPoint.swift
//  Weather
//
//  Created by 서현웅 on 2023/08/06.
//

import Foundation

public protocol TargetType {
    var baseURL: URL { get }
    var path: String { get }
    var requestParameters: [String: Any] { get }
}

enum NewEndPoint {
    case weather(city: String, apiKey: String)
    case forecast(city: String, apiKey: String)
    case image(imageName: String)
    case map(apiKey: String)
}

extension NewEndPoint: TargetType {
    var baseURL: URL {
        switch self {
        case .map:
            return URL(string: "https://tile.openweathermap.org")!
        default:
            return URL(string: "https://api.openweathermap.org")!
        }
    }
    
    var path: String {
        switch self {
        case .weather:
            return "/data/2.5/weather"
        case .forecast:
            return "/data/2.5/forecast"
        case .image:
            return "/img/wn"
        case .map:
            return "/map/temp/0/0/0.png"
        }
    }
    
    var requestParameters: [String : Any] {
        switch self {
        case .weather(let city, let apiKey):
            return ["q": city, "appid": apiKey]
        case .forecast(let city, let apiKey):
            return ["q": city, "appid": apiKey]
        case .image(let imageName):
            return ["image": imageName]
        case .map(let apiKey):
            return ["appid": apiKey]
        }
    }
}
