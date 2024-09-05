//
//  UIColor+Extension.swift
//  Cora
//
//  Created by Fabricio Pujol on 04/09/24.
//

import UIKit.UIColor

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }

    convenience init(hex: String) {
        let start = hex.index(hex.startIndex, offsetBy: 1)
        var hexColor = String(hex[start...])

        // Adding the color differenciation
        if hexColor.count == 5 {
            hexColor += "0"
        }

        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        scanner.scanHexInt64(&hexNumber)

        self.init(rgb: Int(hexNumber))
    }
}
