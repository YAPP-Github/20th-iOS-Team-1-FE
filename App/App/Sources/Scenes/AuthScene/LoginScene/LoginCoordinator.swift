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
            .map { $0.email }
            .distinctUntilChanged()
            .withUnretained(self)
            .subscribe(onNext: { (owner, email) in
                owner.pushSignUpAgreementViewController(with: email)
            })
            .disposed(by: disposeBag)
        
        navigationController.setViewControllers([loginViewController], animated: false)
    }
    
    private func pushSignUpAgreementViewController(with component: String) {
        let signUpAgreementCoordinator = SignUpAgreementCoordinator(navigationController: navigationController, component: component)
        signUpAgreementCoordinator.parentCoordinator = self
        childCoordinators.append(signUpAgreementCoordinator)
        signUpAgreementCoordinator.start()
    }
}
