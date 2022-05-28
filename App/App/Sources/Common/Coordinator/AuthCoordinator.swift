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
    var isSimulator = true

    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        if !isSimulator {
            let loginCoordinator = LoginCoordinator()
            childCoordinators.append(loginCoordinator)
            loginCoordinator.start()
            window?.rootViewController = loginCoordinator.navigationController
        } else {
            let navigationController = UINavigationController()
            let SignUpAgreementCoordinator = SignUpAgreementCoordinator(navigationController: navigationController, component: "Dummy")
            childCoordinators.append(SignUpAgreementCoordinator)
            SignUpAgreementCoordinator.start()
            window?.rootViewController = navigationController
        }
        
        window?.makeKeyAndVisible()
    }
}
