//
//  NewEndPoint.swift
//  Weather
//
//  Created by 서현웅 on 2023/08/06.
//

import Foundation

public protocol TargetType {
    var baseURL: String { get }
    var path: String { get }
    var requestParameters: [URLQueryItem] { get }
    var url: URL? { get }
}

enum EndPoint {
    case weather(city: String)
    case forecast(city: String)
    case image(imageName: String)
    case map
}

extension EndPoint: TargetType {
    var baseURL: String {
        switch self {
        case .map:
            return "https://tile.openweathermap.org"
        default:
            return "https://api.openweathermap.org"
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
    
    var requestParameters: [URLQueryItem] {
        switch self {
        case .weather(let city):
            return [
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "appid", value: SecretStorage().API_KEY)
            ]
        case .forecast(let city):
            return [
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "appid", value: SecretStorage().API_KEY)
            ]
        case .image(let imageName):
            return [
                URLQueryItem(name: "image", value: imageName),
            ]
        case .map:
            return [
                URLQueryItem(name: "appid", value: SecretStorage().API_KEY)
            ]
        }
    }
    
    var url: URL? {
        return asURL()
    }
}

extension EndPoint {
    private func asURL() -> URL? {
        var component = URLComponents()
        component.host = baseURL
        component.path = path
        component.queryItems = requestParameters
        
        return component.url
    }
}

