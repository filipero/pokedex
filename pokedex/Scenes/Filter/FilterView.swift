//
//  FilterView.swift
//  Pokedex
//
//  Created by Filipe Rodrigues Oliveira on 14/02/24.
//

import UIKit
import TinyConstraints

protocol FilterViewProtocol {
    func configure(pokemonTypes: [Pokemon.Types], chipAction: ((Pokemon.Types) -> Void)?)
}

final class FilterView: BaseView {
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    //MARK: - Initialize
    override func initialize() {
        addSubview(scrollView)
        scrollView.edgesToSuperview(usingSafeArea: true)
        scrollView.addSubview(mainStackView)
        mainStackView.edgesToSuperview(insets: .left(16))
        mainStackView.width(to: scrollView, offset: -32)
    }
}

extension FilterView: FilterViewProtocol {
    func configure(pokemonTypes: [Pokemon.Types], chipAction: ((Pokemon.Types) -> Void)?) {
        pokemonTypes.map { type in
            TappableView(type.makeTypeChip())
                .onTap(weak: self) { _ in
                    chipAction?(type)
                }
        }.chunked(into: 3).forEach { types in
            let stackView = UIStackView(arrangedSubviews: types)
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.spacing = 8
            mainStackView.addArrangedSubview(stackView)
        }
    }
}
