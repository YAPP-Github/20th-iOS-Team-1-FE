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
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let tabCoordinator = TabCoordinator(window: window)
        tabCoordinator.start()
    }
}
