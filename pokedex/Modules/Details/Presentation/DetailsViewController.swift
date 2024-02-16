//
//  DetailsViewController.swift
//  Pokedex
//
//  Created by Filipe Rodrigues Oliveira on 07/02/24.
//

import UIKit

final class DetailsViewController: UIViewController {
    private(set) lazy var baseView: DetailsView = {
        let view = DetailsView()
        return view
    }()
    
    let viewModel: DetailsViewModelProtocol
    
    init(viewModel: DetailsViewModelProtocol) {
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
        setupBinds()
    }
    
    private func setupBinds() {
        viewModel.getPokemonData { pokemon in
            DispatchQueue.main.async {
                self.title = pokemon.name?.capitalizingFirstLetter()
                self.setupProfileImage(id: "\(pokemon.id ?? 0)",image: pokemon.sprites?.frontDefault ?? "")

                self.baseView.statusView.configure(viewModel: .init(status: pokemon.stats?.reduce(into: [StatusView.Status : Float](), {
                    if let name = $1.stat?.name,
                       let status = StatusView.Status(rawValue: name),
                       let value = $1.baseStat {
                        let floatValue = Float(value) / 255.0
                        $0[status] = floatValue
                    }
                }) ?? [:]))

                if let types = pokemon.types?.map({ type in
                    Pokemon.Types(rawValue: type.type?.name ?? "") ?? .unknown
                }) {
                    self.baseView.profileImageView.backgroundColor = types.first?.getBackgroundColor().withAlphaComponent(0.8)
                    self.baseView.typesView.configure(viewModel: .init(models: types))
                }

                self.baseView.pokemonDetailsView.configure(viewModel: .init(details: [
                    "Height": "\(Float(pokemon.height ?? 0) / 10.0)m",
                    "Weight": "\(Float(pokemon.weight ?? 0) / 10.0)kg"
                ]))
            }
        }
    }

    private func setupProfileImage(id: String, image: String) {
        baseView.profileImageView.downloaded(from: image)
        baseView.idLabel.text = id.prettyfiedId()
    }
}


