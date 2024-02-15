//
//  TableViewDataSource.swift
//  Pokedex
//
//  Created by Filipe Rodrigues Oliveira on 21/02/22.
//

import UIKit

public class TableViewDataSource<Model>: NSObject, UITableViewDataSource {
  public typealias CellConfigurator = (Model, UITableViewCell) -> Void

  public var models: [Model]
  public var sectionTitle: String? = nil
  private let reuseIdentifier: String
  private let cellConfigurator: CellConfigurator

  public init(models: [Model],
              reuseIdentifier: String,
              cellConfigurator: @escaping CellConfigurator) {
    self.models = models
    self.reuseIdentifier = reuseIdentifier
    self.cellConfigurator = cellConfigurator
  }

  public func tableView(_ tableView: UITableView,
                        numberOfRowsInSection section: Int) -> Int {
    return models.count
  }

  public func tableView(_ tableView: UITableView,
                        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = models[indexPath.row]
    let cell = tableView.dequeueReusableCell(
      withIdentifier: reuseIdentifier,
      for: indexPath
    )

    cellConfigurator(model, cell)
    
    return cell
  }
}

public extension TableViewDataSource {
  func getModel(at indexPath: IndexPath) -> Model? {
    guard models.indices.contains(indexPath.row) else {
      return nil
    }
    return models[indexPath.row]
  }
}
