//
//  Forecast.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/14.
//

import Foundation

struct Forecast: Hashable {
    let id = UUID()
    let dt: String
    let temp : Double
    let icon: String
}
