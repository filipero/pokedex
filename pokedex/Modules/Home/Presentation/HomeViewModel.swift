//
//  HomeViewModel.swift
//  Pokedex
//
//  Created by Filipe Rodrigues Oliveira on 07/02/24.
//

import UIKit

protocol HomeNavigationDelegate: AnyObject {
    func goToDetailScreen(character: PokemonListItem)
    func goToFilterScreen()
}

protocol HomeDelegate: AnyObject {
    func scrollToTop()
    func updateTableView()
}

protocol HomeViewModelProtocol: AnyObject {
    var characterDataSource: TableViewDataSource<PokemonCellViewModel> { get }
    var screenTitle: String { get }
    var isLoadingData: Bool { get }
    var filter: Pokemon.Types? { get }

    func goToDetailsScreen(character: PokemonListItem)
    func goToFilterScreen()
    func getMoreCharacters(filter: Pokemon.Types?)
    func setHomeDelegate(_ delegate: HomeDelegate)
}

class HomeViewModel {
    private var service: HomeWorkerProtocol
    private weak var navigationDelegate: HomeNavigationDelegate?
    private weak var homeDelegate: HomeDelegate?
    private var models: [Int: [PokemonCellViewModel]] = [:]
    internal var filter: Pokemon.Types? = nil {
        didSet {
            models = [Int: [PokemonCellViewModel]]()
        }
    }

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

    func goToFilterScreen() {
        self.navigationDelegate?.goToFilterScreen()
    }

    func getMoreCharacters(filter: Pokemon.Types?) {
        guard let filter else {
            requestCharacters()
            return
        }
        requestListByType(type: filter)
    }

    private func requestCharacters() {
        if filter != nil {
            filter = nil
        }

        isLoadingData = true
        let pageSize = 20
        let pageToBeRequested: Int = Int(models.keys.max() ?? 0) + 1

        service.getPokemonList(request: .init(limit: pageSize, offset: (pageToBeRequested - 1) * pageSize)) { pokemons, error in
            guard let pokemons else { if let error { self.handleError(error: error) }; return }
            self.models[pageToBeRequested] = pokemons.map({ pokemon in
                PokemonCellViewModel(character: pokemon)
            })
            let valueModels = self.models.values.flatMap { $0 }.sorted { Int($0.character.id ?? "") ?? 0 < Int($1.character.id ?? "") ?? 0 }
            self.characterDataSource = .make(for: valueModels )
            self.homeDelegate?.updateTableView()
            self.isLoadingData = false
        }
    }

    private func requestListByType(type: Pokemon.Types) {
        if filter == nil || filter != type {
            filter = type
        } else {
            return
        }
        isLoadingData = true
        service.getPokemonListByType(request: PokemonListByTypeRequest(type: type)) { pokemonList, error in
            guard let pokemonList else { if let error { self.handleError(error: error) }; return }
            self.models[1] = pokemonList.map({ pokemon in
                PokemonCellViewModel(character: pokemon)
            })
            let valueModels = self.models.values.flatMap { $0 }.sorted { Int($0.character.id ?? "") ?? 0 < Int($1.character.id ?? "") ?? 0 }
            self.characterDataSource = .make(for: valueModels )

            self.homeDelegate?.updateTableView()
            self.isLoadingData = false
            if self.models.keys.max() == 1 {
                self.homeDelegate?.scrollToTop()
            }
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
