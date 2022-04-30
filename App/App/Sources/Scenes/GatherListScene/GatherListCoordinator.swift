//
//  GatherListCoordinator.swift
//  App
//
//  Created by Hani on 2022/05/01.
//

import UIKit

final class GatherListCoordinator: SceneCoordinator {
    weak var parentCoordinator: SceneCoordinator?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
    }
    
    func start() {
        let reactor = GatherListReactor()
        let viewController = GatherListViewController(reactor: reactor)
        
        navigationController.setViewControllers([viewController], animated: false)
    }
}
