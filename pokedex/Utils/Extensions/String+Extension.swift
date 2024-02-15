//
//  String+Extension.swift
//  Pokedex
//
//  Created by Filipe Rodrigues Oliveira on 21/02/22.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }

    func prettyfiedId() -> String {
        let zeroAmount = 4 - self.count
        if zeroAmount <= 0 {
            return "#" + self
        }
        return "#\(String(repeating: "0", count: zeroAmount))\(self)"
    }
}
