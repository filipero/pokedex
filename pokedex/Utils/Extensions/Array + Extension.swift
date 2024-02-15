//
//  Array + Extension.swift
//  Pokedex
//
//  Created by Filipe Rodrigues Oliveira on 14/02/24.
//

import Foundation

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
