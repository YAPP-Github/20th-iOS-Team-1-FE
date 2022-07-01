//
//  ChattingCoordinator.swift
//  App
//
//  Created by Hani on 2022/05/01.
//

import UIKit

final class ChattingCoordinator: SceneCoordinator {
    weak var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
    }
    
    func start() {
        let reactor = ChattingReactor()
        let viewController = ChattingViewController(reactor: reactor)
        
        navigationController.setViewControllers([viewController], animated: false)
    }
}
