//
//  StatusView.swift
//  Pokedex
//
//  Created by Filipe Rodrigues Oliveira on 12/02/24.
//

import UIKit
import TinyConstraints

protocol StatusViewProtocol {
    func configure(viewModel: StatusView.ViewModel)
}

class StatusView: BaseView {
    enum Status: String {
        case healthPoints = "hp"
        case attack = "attack"
        case defense = "defense"
        case specialAttack = "special-attack"
        case specialDefense = "special-defense"
        case speed = "speed"
        case accuracy = "accuracy"
        case evasion = "evasion"

        var displayName: String {
            switch self {
            case .healthPoints:
                return "Health"
            case .attack:
                return "Attack"
            case .defense:
                return "Defense"
            case .specialAttack:
                return "SP.Attack"
            case .specialDefense:
                return "SP.Defense"
            case .speed:
                return "Speed"
            case .accuracy:
                return "Accuracy"
            case .evasion:
                return "Evasion"
            }
        }

        var order: Int {
            switch self {
            case .healthPoints:
                return 0
            case .attack:
                return 1
            case .defense:
                return 2
            case .specialAttack:
                return 3
            case .specialDefense:
                return 4
            case .speed:
                return 5
            case .accuracy:
                return 6
            case .evasion:
                return 7
            }
        }
    }

    struct ViewModel {
        let status: [Status: Float]
    }

    private lazy var StatsLabel: UILabel = {
        let view = UILabel()
        view.text = "Stats:"
        view.font = .boldSystemFont(ofSize: 24)
        return view
    }()

    private lazy var StatsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        view.distribution = .fillEqually
        return view
    }()

    private lazy var mainStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [StatsLabel, StatsStackView])
        view.axis = .vertical
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func initialize() {
        addSubview(mainStackView)
        mainStackView.edgesToSuperview(insets: .uniform(8))
    }

    private func makeStatusRow(for status: Status, with value: Float) -> UIStackView {
        lazy var progressBar: UIProgressView = {
            let view = UIProgressView()
            view.clipsToBounds = true
            view.trackTintColor = .systemGray.withAlphaComponent(0.3)
            view.progress = value
            view.progressTintColor = {
                switch value {
                case 0.0 ... 0.25:
                    return .systemRed
                case 0.26 ... 0.50:
                    return .systemOrange
                case 0.51 ... 0.75:
                    return .systemYellow
                case 0.76 ... 0.99:
                    return .systemGreen
                case 1.0:
                    return .systemBlue
                default:
                    return .systemRed
                }
            }()
            view.layer.cornerRadius = 10
            view.layer.borderWidth = 2
            view.layer.borderColor = UIColor.systemGray.withAlphaComponent(0.5).cgColor
            view.height(24)
            view.width(240)
            return view
        }()

        lazy var label: UILabel = {
            let view = UILabel()
            view.text = status.displayName
            return view
        }()

        lazy var stackview: UIStackView = {
            let view = UIStackView(arrangedSubviews: [label, progressBar])
            view.spacing = 4
            return view
        }()
        return stackview
    }
}

extension StatusView: StatusViewProtocol {
    func configure(viewModel: StatusView.ViewModel) {
        viewModel.status.sorted { $0.key.order < $1.key.order }.forEach { status, value in
            StatsStackView.addArrangedSubview(makeStatusRow(for: status, with: value))
        }
    }
}

