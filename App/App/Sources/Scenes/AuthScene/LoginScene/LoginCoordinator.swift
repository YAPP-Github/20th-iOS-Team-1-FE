//
//  LoginCoordinator.swift
//  App
//
//  Created by Hani on 2022/05/24.
//

import UIKit

import RxSwift

final class LoginCoordinator: SceneCoordinator {
    var parentCoordinator: SceneCoordinator?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
    }
    
    func start() {
        let networkManager = NetworkManager.shared
        let appleLoginRepository = AppleLoginRepository(networkManager: networkManager)
        let keychainProvider = KeychainProvider.shared
        let loginReactor = LoginReactor(appleLoginRepository: appleLoginRepository, keychainProvider: keychainProvider)
        let loginViewController = LoginViewController(reactor: loginReactor)

        navigationController.setViewControllers([loginViewController], animated: false)
    }
    
    private func pushSignUpAgreementViewController() {
        let signUpAgreementCoordinator = SignUpAgreementCoordinator(navigationController: navigationController)
        signUpAgreementCoordinator.parentCoordinator = self
        childCoordinators.append(signUpAgreementCoordinator)
        signUpAgreementCoordinator.start()
    }
}
