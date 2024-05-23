//
//  Double+Extensions.swift
//  UpStocks
//
//  Created by K Praveen Kumar on 23/05/24.
//

import Foundation

extension Double {
    
    func toString(withFractionDigits fractionDigits: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = fractionDigits
        formatter.maximumFractionDigits = fractionDigits
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
    
    func toCurrencyString() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: self))
    }
    
    func toPercentageString(decimalPlaces: Int = 2) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumFractionDigits = decimalPlaces
        formatter.maximumFractionDigits = decimalPlaces
        
        if let formattedString = formatter.string(from: NSNumber(value: self)) {
            return "(\(formattedString))"
        }
        return nil
    }
}
