//
//  HomeView.swift
//  pokedex
//
//  Created by Filipe Rodrigues Oliveira on 07/02/24.
//

import UIKit

final class HomeView: BaseView {
    let tableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.allowsSelection = true
        view.register(PokemonCellView.self,
                      forCellReuseIdentifier: PokemonCellView.identifier)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

  //MARK: - Initialize
  override func initialize() {
      addSubview(tableView)
      backgroundColor = .white
      tableView.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
      tableView.bottomToSuperview()
  }
}
