//
//  TypeModel.swift
//  Pokedex
//
//  Created by Filipe Rodrigues Oliveira on 13/02/24.
//

import Foundation

// MARK: - TypeResponse
struct TypeResponse: Codable {
    let pokemon: [Pokemon]?

    enum CodingKeys: String, CodingKey {
        case pokemon
    }

    // MARK: - Generation
    struct PokemonType: Codable {
        let name: String?
        let url: String?
    }

    // MARK: - Pokemon
    struct Pokemon: Codable {
        let pokemon: PokemonListItem?
    }
}
