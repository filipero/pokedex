//
//  FilterViewModel.swift
//  Pokedex
//
//  Created by Filipe Rodrigues Oliveira on 14/02/24.
//

import UIKit

protocol FilterNavigationDelegate: AnyObject {
    func goToHomeScreen(with type: Pokemon.Types)
}

protocol FilterViewModelProtocol: AnyObject {
    var screenTitle: String { get }
    var pokemonTypes: [Pokemon.Types] { get }

    func goToHomeScreen(with type: Pokemon.Types)
}

class FilterViewModel: FilterViewModelProtocol {
    let screenTitle: String = "Filter"
    let pokemonTypes: [Pokemon.Types] = Pokemon.Types.allCases
    private weak var navigationDelegate: FilterNavigationDelegate?
    
    init(navigationDelegate: FilterNavigationDelegate?) {
        self.navigationDelegate = navigationDelegate
    }

    func goToHomeScreen(with type: Pokemon.Types) {
        self.navigationDelegate?.goToHomeScreen(with: type)
    }

    private func handleError(error: Error) {
        print(error)
    }
}

