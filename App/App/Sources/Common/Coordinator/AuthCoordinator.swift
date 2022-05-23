//
//  AuthCoordinator.swift
//  App
//
//  Created by Hani on 2022/05/22.
//

import UIKit

import RxSwift

final class AuthCoordinator: Coordinator {
    private let window: UIWindow?
    var childCoordinators = [Coordinator]()
    var disposeBag = DisposeBag()
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let loginCoordinator = LoginCoordinator()
        childCoordinators.append(loginCoordinator)
        loginCoordinator.start()
        
        window?.rootViewController = loginCoordinator.navigationController
        window?.makeKeyAndVisible()
    }
}
