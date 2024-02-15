//
//  Coordinator.swift
//  Pokedex
//
//  Created by Filipe Rodrigues Oliveira on 07/02/24.
//

import Foundation

public protocol Coordinator: AnyObject {
  var childCoordinators: [Coordinator] { get set }

  func start()
}

public extension Coordinator {
  @discardableResult func addChildCoordinator(_ childCoordinator: Coordinator) -> Coordinator {
    self.childCoordinators.append(childCoordinator)
    return childCoordinator
  }

  @discardableResult func removeChildCoordinator(_ childCoordinator: Coordinator) -> Coordinator {
    self.childCoordinators = self.childCoordinators.filter { $0 !== childCoordinator }
    return childCoordinator
  }
}

public protocol CoordinatorDelegate: AnyObject {
  func didClose(childCoordinator: Coordinator)
}
