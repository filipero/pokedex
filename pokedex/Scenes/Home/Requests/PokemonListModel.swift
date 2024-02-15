//
//  PokemonListModel.swift
//  Pokedex
//
//  Created by Filipe Rodrigues Oliveira on 08/02/24.
//

import UIKit

struct PokemonListResponse: Codable {
    let count: Int
    let next: String
    let previous: String?
    let results: [PokemonListItem]
}

struct PokemonListItem: Codable {
    var id: String?
    var url: String
    let name: String

    init(id: String? = nil, url: String, name: String) {
        self.id = id
        self.url = url
        self.name = name
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decode(String.self, forKey: .url)
        name = try container.decode(String.self, forKey: .name)
        id = url.components(separatedBy: "/").dropLast().last ?? ""
      }
}
