//
//  Double+Extension.swift
//  Weather
//
//  Created by 서현웅 on 2023/06/23.
//

import Foundation

extension Double {
    func convertCelciusTemp() -> String {
        let celciusInt = Int(UnitTemperature.celsius.converter.value(fromBaseUnitValue: self))
        
        return celciusInt.description + "°"
    }
    
    func convertCelciusTempDouble() -> Double {
        let intTemp = Int(UnitTemperature.celsius.converter.value(fromBaseUnitValue: self))
        return Double(intTemp)
    }
}
