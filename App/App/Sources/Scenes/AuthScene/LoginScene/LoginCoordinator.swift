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
        let loginReactor = LoginReactor()
        let loginViewController = LoginViewController(reactor: loginReactor)

        loginViewController.reactor?.state
            .map { $0.user }
            .distinctUntilChanged(==)
            .withUnretained(self)
            .subscribe(onNext: { (owner, user) in
                owner.pushSignUpAgreementViewController(with: user)
            })
            .disposed(by: disposeBag)
        
        navigationController.setViewControllers([loginViewController], animated: false)
    }
    
    private func pushSignUpAgreementViewController(with user: UserAuthentification) {
        let signUpAgreementCoordinator = SignUpAgreementCoordinator(navigationController: navigationController, user: user)
        signUpAgreementCoordinator.parentCoordinator = self
        childCoordinators.append(signUpAgreementCoordinator)
        signUpAgreementCoordinator.start()
    }
}
