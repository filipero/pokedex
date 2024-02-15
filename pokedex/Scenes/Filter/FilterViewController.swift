//
//  FilterViewController.swift
//  Pokedex
//
//  Created by Filipe Rodrigues Oliveira on 14/02/24.
//

import UIKit

final class FilterViewController: UIViewController {
    private(set) lazy var baseView: FilterView = {
        let view = FilterView()
        return view
    }()

    let viewModel: FilterViewModelProtocol

    init(viewModel: FilterViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: .main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func loadView() {
        super.loadView()
        view = baseView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.screenTitle
        setupBinds()
    }

    private func setupBinds() {
        baseView.configure(pokemonTypes: viewModel.pokemonTypes, chipAction: { self.viewModel.goToHomeScreen(with: $0)
        })
    }
}



