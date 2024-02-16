//
//  HomeCoordinator.swift
//  Pokedex
//
//  Created by Filipe Rodrigues Oliveira on 07/02/24.
//

import UIKit

final class HomeCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator] = []
    private let presenter: UINavigationController
    private weak var navigationDelegate: CoordinatorDelegate?

    init(presenter: UINavigationController,
         navigationDelegate: CoordinatorDelegate? = nil) {
        self.presenter = presenter
        self.navigationDelegate = navigationDelegate
    }

    // MARK: - Functions

    func start() {
        let homeViewModel = HomeViewModel(service: HomeWorker(),
                                          navigationDelegate: self)
        let homeViewController = HomeViewController(viewModel: homeViewModel)

        presenter.pushViewController(homeViewController, animated: true)
    }
}

extension HomeCoordinator: HomeNavigationDelegate {
    func goToDetailScreen(character: PokemonListItem) {
        let detailsScreenViewModel = DetailsViewModel(pokemonName: character.name)
        let detailsViewController = DetailsViewController(viewModel: detailsScreenViewModel)

        presenter.pushViewController(detailsViewController, animated: true)
    }

    func goToFilterScreen() {
        let filterViewModel = FilterViewModel(navigationDelegate: self)
        let filterViewController = FilterViewController(viewModel: filterViewModel)

        presenter.pushViewController(filterViewController, animated: true)
    }
}

extension HomeCoordinator: FilterNavigationDelegate {
    func goToHomeScreen(with type: Pokemon.Types) {
        presenter.popViewController(animated: true)
        let controller = presenter.topViewController as? HomeViewController
        controller?.viewModel.getMoreCharacters(filter: type)
    }
}

extension HomeCoordinator: CoordinatorDelegate {
    func didClose(childCoordinator: Coordinator) {
      removeChildCoordinator(childCoordinator)
    }
}
