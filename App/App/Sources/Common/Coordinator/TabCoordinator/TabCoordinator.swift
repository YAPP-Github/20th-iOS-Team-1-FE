//
//  TabCoordinator.swift
//  App
//
//  Created by Hani on 2022/04/23.
//

import UIKit

final class TabCoordinator: Coordinator {
    private let window: UIWindow?
    var childCoordinators = [Coordinator]()
    
    init(window: UIWindow?) {
        self.window = window
        
        window?.makeKeyAndVisible()
    }
    
    func start() {
        let firstCoordinator = AuthCoordinator()
        childCoordinators.append(firstCoordinator)
        firstCoordinator.start()
        let firstViewController = firstCoordinator.navigationController
        firstViewController.tabBarItem = UITabBarItem(title: "Auth", image: nil, selectedImage: nil)
        
        let secondCoordinator = GatherListCoordinator()
        childCoordinators.append(secondCoordinator)
        secondCoordinator.start()
        let secondViewController = secondCoordinator.navigationController
        secondViewController.tabBarItem = UITabBarItem(title: "Gather", image: nil, selectedImage: nil)
        
        let thirdCoordinator = ChattingCoordinator()
        childCoordinators.append(thirdCoordinator)
        thirdCoordinator.start()
        let thirdViewController = thirdCoordinator.navigationController
        thirdViewController.tabBarItem = UITabBarItem(title: "Chatting", image: nil, selectedImage: nil)
        
        let fourthCoordinator = ProfileCoordinator()
        childCoordinators.append(fourthCoordinator)
        fourthCoordinator.start()
        let fourthViewController = fourthCoordinator.navigationController
        fourthViewController.tabBarItem = UITabBarItem(title: "Profile", image: nil, selectedImage: nil)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [firstViewController, secondViewController, thirdViewController, fourthViewController]
        
        window?.rootViewController = tabBarController
    }
}
