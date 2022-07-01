//
//  ProfileCoordinator.swift
//  App
//
//  Created by Hani on 2022/05/01.
//

import UIKit

final class ProfileCoordinator: SceneCoordinator {
    weak var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
    }
    
    func start() {
        let networkManager = NetworkManager.shared
        let profileMainRepository = ProfileRespository(networkManager: networkManager)
        let reactor = ProfileReactor(profileMainRepository: profileMainRepository)
        let viewController = ProfileViewController(reactor: reactor)
        
        navigationController.setViewControllers([viewController], animated: false)
    }
}
