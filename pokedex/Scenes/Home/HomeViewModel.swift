//
//  HomeViewModel.swift
//  pokedex
//
//  Created by Filipe Rodrigues Oliveira on 07/02/24.
//

import UIKit

protocol HomeNavigationDelegate: AnyObject {
    func goToDetailScreen(character: PokemonListItem)
}

protocol HomeDelegate: AnyObject {
    func scrollToTop()
    func updateTableView()
}

protocol HomeViewModelProtocol: AnyObject {
    var characterDataSource: TableViewDataSource<PokemonCellViewModel> { get }
    var screenTitle: String { get }
    var isLoadingData: Bool { get }

    func goToDetailsScreen(character: PokemonListItem)
    func requestCharacters()
    func setHomeDelegate(_ delegate: HomeDelegate)
}

class HomeViewModel {
    private var service: HomeWorkerProtocol
    private weak var navigationDelegate: HomeNavigationDelegate?
    private weak var homeDelegate: HomeDelegate?
    private var models: [Int: [PokemonCellViewModel]] = [:]

    var characterDataSource: TableViewDataSource<PokemonCellViewModel> = .make(for: [])
    var screenTitle: String = "Pokemon"
    private(set) var isLoadingData: Bool = false

    init(service: HomeWorkerProtocol = HomeWorker(),
         navigationDelegate: HomeNavigationDelegate? = nil) {
        self.service = service
        self.navigationDelegate = navigationDelegate
    }

    private func handleError(error: Error) {
        print(error)
    }
}

//MARK: - HomeViewModelProtocol

extension HomeViewModel: HomeViewModelProtocol {
    func setHomeDelegate(_ delegate: HomeDelegate) {
        self.homeDelegate = delegate
    }

    func goToDetailsScreen(character: PokemonListItem) {
        self.navigationDelegate?.goToDetailScreen(character: character)
    }

    func requestCharacters() {
        isLoadingData = true
        let pageSize = 20
        let pageToBeRequested: Int = Int(models.keys.max() ?? 0) + 1

        service.getPokemonList(request: .init(limit: pageSize, offset: (pageToBeRequested - 1) * pageSize)) { pokemons, error in
            guard let pokemons else { if let error { self.handleError(error: error) }; return }
            let mappedCharacters = pokemons.map({ pokemon in
                PokemonCellViewModel(character: pokemon)
            })
            self.models[pageToBeRequested] = mappedCharacters
            let valueModels = self.models.values.flatMap { $0 }.sorted { Int($0.character.id ?? "") ?? 0 < Int($1.character.id ?? "") ?? 0 }
            self.characterDataSource = .make(for: valueModels )
            self.homeDelegate?.updateTableView()
            self.isLoadingData = false
        }
    }
}

fileprivate extension TableViewDataSource where Model == PokemonCellViewModel {
    static func make(for models: [PokemonCellViewModel], reuseIdentifier: String = PokemonCellView.identifier) -> TableViewDataSource<Model> {
        TableViewDataSource(models: models,
                            reuseIdentifier: PokemonCellView.identifier) { model, cell in
            if let cell = cell as? PokemonCellView {
                model.configure(cell: cell)
            }
        }
    }
}
