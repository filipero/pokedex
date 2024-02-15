//
//  UIColor+Extension.swift
//  Pokedex
//
//  Created by Filipe Rodrigues Oliveira on 12/02/24.
//

import UIKit

extension UIColor {

    static func random(hue: CGFloat = CGFloat.random(in: 0...1),
                       saturation: CGFloat = CGFloat.random(in: 0.5...1),
                       brightness: CGFloat = CGFloat.random(in: 0.5...1),
                       alpha: CGFloat = 1) -> UIColor {
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }

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
}
