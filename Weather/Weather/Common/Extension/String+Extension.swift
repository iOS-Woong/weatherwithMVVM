//
//  String+Extension.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/23.
//

import Foundation

extension String {
    func convertCityNameToKr() -> String? {
        guard let queryItem = QueryItem(rawValue: self.lowercased()) else { return nil }
        
        return queryItem.cityNameKr
    }
}
