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
        let secondCoordinator = SearchCoordinator()
        childCoordinators.append(secondCoordinator)
        secondCoordinator.parentCoordinator = self
        secondCoordinator.start()
        let secondViewController = secondCoordinator.navigationController
        secondViewController.tabBarItem = UITabBarItem(title: "찾기", image: .Togaether.searchIcon, selectedImage: .Togaether.searchIconFill)
        
        let thirdCoordinator = GatherListCoordinator()
        childCoordinators.append(thirdCoordinator)
        thirdCoordinator.parentCoordinator = self
        thirdCoordinator.start()
        let thirdViewController = thirdCoordinator.navigationController
        thirdViewController.tabBarItem = UITabBarItem(title: "내모임", image: .Togaether.gatherIcon, selectedImage: .Togaether.gatherIconFill)
        
        
        let fourthCoordinator = ProfileCoordinator()
        childCoordinators.append(fourthCoordinator)
        fourthCoordinator.parentCoordinator = self
        fourthCoordinator.delegate = self.delegate
        fourthCoordinator.start()
        let fourthViewController = fourthCoordinator.navigationController
        fourthViewController.tabBarItem = UITabBarItem(title: "마이페이지", image: .Togaether.myPageIcon, selectedImage: .Togaether.myPageIconFill)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [secondViewController, thirdViewController, fourthViewController]
        tabBarController.tabBar.tintColor = .Togaether.primaryLabel
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}

protocol TabBarCoordinatorDelegate: AnyObject {
    func switchToAuth()
}

