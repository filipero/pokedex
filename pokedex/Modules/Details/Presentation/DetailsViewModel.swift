//
//  DetailsViewModel.swift
//  Pokedex
//
//  Created by Filipe Rodrigues Oliveira on 07/02/24.
//

import UIKit

protocol DetailsViewModelProtocol: AnyObject {
    func getPokemonData(completion: @escaping (Pokemon) -> Void)
    var screenTitle: String { get }
}

class DetailsViewModel: DetailsViewModelProtocol {
    let screenTitle: String

    private var service: DetailsWorkerProtocol
    
    init(
        service: DetailsWorkerProtocol = DetailsWorker(),
        pokemonName: String
    ){
        screenTitle = pokemonName.capitalizingFirstLetter()
        self.service = service
    }

    private func handleError(error: Error) {
        print(error)
    }

    func getPokemonData(completion: @escaping (Pokemon) -> Void) {
        service.getPokemonDetails(request: DetailsRequest(pokemonName: screenTitle.lowercased())) { pokemon, error in
            guard let pokemon else { if let error { self.handleError(error: error) }; return }
            completion(pokemon)
        }
    }
}
