//
//  TabCoordinator.swift
//  App
//
//  Created by Hani on 2022/04/23.
//

import UIKit

final class TabCoordinator: Coordinator {
    private let window: UIWindow?
    
    internal var childCoordinators = [Coordinator]()
    
    init(window: UIWindow?) {
        self.window = window
        
        window?.makeKeyAndVisible()
    }
    
    internal func start() {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = []
        
        window?.rootViewController = tabBarController
    }
}
