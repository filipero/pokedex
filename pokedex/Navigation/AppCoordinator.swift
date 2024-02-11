//
//  AppCoordinator.swift
//  pokedex
//
//  Created by Filipe Rodrigues Oliveira on 07/02/24.
//

import UIKit

class AppCoordinator: Coordinator {
  let window: UIWindow
  var childCoordinators: [Coordinator] = []
  var rootViewController: UIViewController {
    return self.navigationController
  }

  lazy var navigationController: UINavigationController = {
    let navigationController = UINavigationController()
    return navigationController
  }()

    lazy var viewController: UIViewController = {
        let controller = UIViewController()
        controller.view.backgroundColor = .blue
        return controller
    }()

  init(window: UIWindow) {
    self.window = window
    self.window.rootViewController = self.rootViewController
    self.window.makeKeyAndVisible()
  }

  func start() {
    let homeCoordinator = HomeCoordinator(presenter: navigationController, navigationDelegate: self)
    addChildCoordinator(homeCoordinator)
    homeCoordinator.start()
  }
}

extension AppCoordinator: CoordinatorDelegate {
  func didClose(childCoordinator: Coordinator) {
    removeChildCoordinator(childCoordinator)
  }
}
