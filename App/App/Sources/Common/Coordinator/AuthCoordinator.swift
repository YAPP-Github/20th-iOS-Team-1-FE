//
//  AuthCoordinator.swift
//  App
//
//  Created by Hani on 2022/05/22.
//

import UIKit

final class AuthCoordinator: Coordinator {
    private let window: UIWindow?
    var childCoordinators = [Coordinator]()
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let loginReactor = LoginReactor()
        let loginViewController = LoginViewController(reactor: loginReactor)
        
        window?.rootViewController = loginViewController
        window?.makeKeyAndVisible()
    }
}
