//
//  PokemonDetailsView.swift
//  Pokedex
//
//  Created by Filipe Rodrigues Oliveira on 13/02/24.
//

import UIKit
import TinyConstraints

protocol PokemonDetailsViewProtocol {
    func configure(viewModel: PokemonDetailsView.ViewModel)
}

class PokemonDetailsView: BaseView {
    struct ViewModel {
        let details: [String: String]
    }

    private lazy var detailsLabel: UILabel = {
        let view = UILabel()
        view.text = "Details:"
        view.font = .boldSystemFont(ofSize: 24)
        return view
    }()

    private lazy var detailsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        view.distribution = .fillEqually
        return view
    }()

    private lazy var mainStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [detailsLabel, detailsStackView])
        view.axis = .vertical
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func initialize() {
        addSubview(mainStackView)
        mainStackView.edgesToSuperview(insets: .uniform(8))
    }
}

extension PokemonDetailsView: PokemonDetailsViewProtocol {
    func configure(viewModel: PokemonDetailsView.ViewModel) {
        viewModel.details.sorted { $0.key < $1.key }.forEach { key, value in
            lazy var detailsLabel: UILabel = {
                let view = UILabel()
                view.text = "\(key): \(value)"
                return view
            }()
            detailsStackView.addArrangedSubview(detailsLabel)
        }
    }
}


