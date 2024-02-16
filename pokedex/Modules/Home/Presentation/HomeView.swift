//
//  HomeView.swift
//  Pokedex
//
//  Created by Filipe Rodrigues Oliveira on 07/02/24.
//

import UIKit
import TinyConstraints

final class HomeView: BaseView {
    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.separatorStyle = .none
        
        view.register(PokemonCellView.self,
                      forCellReuseIdentifier: PokemonCellView.identifier)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

  //MARK: - Initialize
  override func initialize() {
      addSubview(tableView)
      tableView.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
      tableView.bottomToSuperview()
  }
}
