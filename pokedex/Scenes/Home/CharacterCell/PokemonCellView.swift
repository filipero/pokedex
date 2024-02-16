//
//  PokemonCellView.swift
//  Pokedex
//
//  Created by Filipe Rodrigues Oliveira on 07/02/24.
//

import UIKit

final class PokemonCellView: UITableViewCell {
    static let identifier = "PokemonCellView"
    lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 24)
        return view
    }()
    lazy var idLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16)
        view.textColor = .systemGray
        return view
    }()

    private lazy var detailsStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [UIView(), nameLabel, idLabel, UIView()])
        view.axis = .vertical
        view.distribution = .equalCentering
        return view
    }()
    lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemGray3
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 32
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.layer.borderWidth = 2
        view.clipsToBounds = true
        return view
    }()
    private lazy var mainStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [detailsStackView,
                                                  profileImageView])
        view.spacing = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let cellBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        cellBackgroundView.layer.shadowColor = UIColor.label.cgColor
    }
    
    // MARK: - Initialize
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupComponents() {
        backgroundColor = .clear
        contentView.addSubview(cellBackgroundView.asCard())
        cellBackgroundView.edgesToSuperview(insets: .uniform(8))
        cellBackgroundView.height(80)
        cellBackgroundView.addSubview(mainStackView)
        mainStackView.edgesToSuperview(insets: .uniform(8))
        profileImageView.width(64)
    }
}
