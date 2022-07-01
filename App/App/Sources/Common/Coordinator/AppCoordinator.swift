//
//  AppCoordinator.swift
//  App
//
//  Created by Hani on 2022/05/22.
//

import UIKit

final class AppCoordinator: Coordinator {
    private let window: UIWindow?
    weak var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var isAlreadyLoggedIn = false
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        if isAlreadyLoggedIn {
            let tabCoordinator = TabCoordinator(window: window)
            childCoordinators.append(tabCoordinator)
            tabCoordinator.delegate = self
            tabCoordinator.start()
        } else {
            let authCoordinator = AuthCoordinator(window: window)
            childCoordinators.append(authCoordinator)
            authCoordinator.delegate = self
            authCoordinator.start()
        }
    }
}

extension AppCoordinator: AuthCoordinatorDelegate {
    func switchToTabBar() {
        childCoordinators.removeAll()
        let tabCoordinator = TabCoordinator(window: window)
        childCoordinators.append(tabCoordinator)
        tabCoordinator.delegate = self
        tabCoordinator.start()
    }
}

extension AppCoordinator: TabBarCoordinatorDelegate {
    func switchToAuth() {
        childCoordinators.removeAll()
        let authCoordinator = AuthCoordinator(window: window)
        childCoordinators.append(authCoordinator)
        authCoordinator.delegate = self
        authCoordinator.start()
    }
}
