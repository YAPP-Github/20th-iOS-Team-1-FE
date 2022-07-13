//
//  GatherListCoordinator.swift
//  App
//
//  Created by Hani on 2022/05/01.
//

import UIKit

final class GatherListCoordinator: SceneCoordinator {
    weak var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
    }
    
    func start() {
        let networkManager = NetworkManager.shared
        let keychainProvider = KeychainProvider.shared
        let keychainUseCase = KeychainUsecase(keychainProvider: keychainProvider, networkManager: networkManager)
        let gatherListRepository = GatherListRepository(networkManager: networkManager)
        let reactor = GatherListReactor(gatherListRepository: gatherListRepository, keychainUseCase: keychainUseCase)
        let viewController = GatherListViewController(reactor: reactor)
        
        navigationController.setViewControllers([viewController], animated: false)
    }
}
