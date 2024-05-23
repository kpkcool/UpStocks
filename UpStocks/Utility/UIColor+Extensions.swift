//
//  UIColor+Extesnions.swift
//  UpStocks
//
//  Created by K Praveen Kumar on 23/05/24.
//

import UIKit

extension UIColor {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let mainColor = UIColor(named: "mainColor")
    let textColor = UIColor(named: "textColor")
}
