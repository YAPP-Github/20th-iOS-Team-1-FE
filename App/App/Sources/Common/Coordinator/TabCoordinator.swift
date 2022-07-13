//
//  TabCoordinator.swift
//  App
//
//  Created by Hani on 2022/04/23.
//

import UIKit

final class TabCoordinator: Coordinator {
    private let window: UIWindow?
    weak var delegate: TabBarCoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let secondCoordinator = GatherListCoordinator()
        childCoordinators.append(secondCoordinator)
        secondCoordinator.parentCoordinator = self
        secondCoordinator.start()
        let secondViewController = secondCoordinator.navigationController
        secondViewController.tabBarItem = UITabBarItem(title: "Gather", image: nil, selectedImage: nil)
        
        let thirdCoordinator = SearchCoordinator()
        childCoordinators.append(thirdCoordinator)
        thirdCoordinator.parentCoordinator = self
        thirdCoordinator.start()
        let thirdViewController = thirdCoordinator.navigationController
        thirdViewController.tabBarItem = UITabBarItem(title: "Search", image: nil, selectedImage: nil)
        
        let fourthCoordinator = ProfileCoordinator()
        childCoordinators.append(fourthCoordinator)
        fourthCoordinator.parentCoordinator = self
        fourthCoordinator.start()
        let fourthViewController = fourthCoordinator.navigationController
        fourthViewController.tabBarItem = UITabBarItem(title: "Profile", image: nil, selectedImage: nil)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [secondViewController, thirdViewController, fourthViewController]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}

protocol TabBarCoordinatorDelegate: AnyObject {
    func switchToAuth()
}

