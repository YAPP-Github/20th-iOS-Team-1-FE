//
//  AppCoordinator.swift
//  App
//
//  Created by Hani on 2022/05/22.
//

import UIKit

final class AppCoordinator: Coordinator {
    private let window: UIWindow?
    var childCoordinators = [Coordinator]()
    var isAlreadyLoggedIn = true
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        if isAlreadyLoggedIn {
            let tabCoordinator = TabCoordinator(window: window)
            tabCoordinator.start()
        } else {
            let authCoordinator = AuthCoordinator(window: window)
            authCoordinator.start()
        }
    }
}
