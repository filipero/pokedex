//
//  TypesView.swift
//  Pokedex
//
//  Created by Filipe Rodrigues Oliveira on 12/02/24.
//

import UIKit
import TinyConstraints

protocol TypesViewProtocol {
    func configure(viewModel: TypesView.ViewModel)
}

class TypesView: BaseView {
    struct ViewModel {
        var models: [Pokemon.Types]
    }
    private lazy var typesLabel: UILabel = {
        let view = UILabel()
        view.text = "Types:"
        view.font = .boldSystemFont(ofSize: 24)
        return view
    }()

    private lazy var typesStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
        return view
    }()

    private lazy var mainStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [typesLabel, typesStackView])
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

extension TypesView: TypesViewProtocol {
    func configure(viewModel: TypesView.ViewModel) {
        viewModel.models.forEach { type in
            typesStackView.addArrangedSubview(type.makeTypeChip())
        }
    }
}
