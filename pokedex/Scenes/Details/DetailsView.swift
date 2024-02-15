//
//  DetailsView.swift
//  Pokedex
//
//  Created by Filipe Rodrigues Oliveira on 07/02/24.
//

import UIKit
import TinyConstraints

protocol DetailsViewProtocol {
    func configure()
}

final class DetailsView: BaseView {
    lazy var idLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 24)
        view.textColor = .label
        view.shadowOffset = .zero
        return view
    }()
    lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 24
        view.addSubview(idLabel)
        return view.asCard()
    }()

    lazy var statusView: StatusView = {
        let view = StatusView()
        return view.asCard()
    }()

    lazy var typesView: TypesView = {
        let view = TypesView()
        return view.asCard()
    }()

    lazy var pokemonDetailsView: PokemonDetailsView = {
        let view = PokemonDetailsView()
        return view.asCard()
    }()

    lazy var evolutionsView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        return view
    }()

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            profileImageView,
            pokemonDetailsView,
            statusView,
            typesView
        ])

        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - Initialize
    override func initialize() {
        backgroundColor = .systemBackground
        addSubview(scrollView)
        scrollView.edgesToSuperview(usingSafeArea: true)
        scrollView.addSubview(mainStackView)
        mainStackView.edgesToSuperview(insets: .left(16))
        mainStackView.width(to: scrollView, offset: -32)

        profileImageView.height(300)
        idLabel.edgesToSuperview(
            excluding: [.top, .leading],
            insets: .right(16) + .bottom(16)
        )
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        profileImageView.layer.shadowColor = UIColor.label.cgColor
        pokemonDetailsView.layer.shadowColor = UIColor.label.cgColor
        statusView.layer.shadowColor = UIColor.label.cgColor
        typesView.layer.shadowColor = UIColor.label.cgColor
    }
}
