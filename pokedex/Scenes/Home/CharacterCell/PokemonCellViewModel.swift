//
//  PokemonCellViewModel.swift
//  pokedex
//
//  Created by Filipe Rodrigues Oliveira on 07/02/24.
//

import Foundation

class PokemonCellViewModel {
    let character: PokemonListItem
    init(character: PokemonListItem) {
        self.character = character
    }
    
    func configure(cell: PokemonCellView) {
        let imageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\( character.id ?? "").png"
        cell.profileImageView.downloaded(from: imageUrl)
        cell.nameLabel.text = character.name.capitalizingFirstLetter()
        cell.idLabel.text = character.id?.prettyfiedId()
    }
}
