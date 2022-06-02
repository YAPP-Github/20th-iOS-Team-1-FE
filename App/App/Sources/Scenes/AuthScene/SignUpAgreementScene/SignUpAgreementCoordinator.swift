//
//  SignUpAgreementCoordinator.swift
//  App
//
//  Created by Hani on 2022/05/24.
//

import UIKit

import RxSwift

final class SignUpAgreementCoordinator: SceneCoordinator {
    private var user: UserAuthentification
    
    var parentCoordinator: SceneCoordinator?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController, user: UserAuthentification) {
        self.navigationController = navigationController
        self.user = user
    }
    
    func start() {
        let signUpAgreementReactor = SignUpAgreementReactor(user: user)
        let signUpAgreementViewController = SignUpAgreementViewController(reactor: signUpAgreementReactor)

        signUpAgreementReactor.state
            .distinctUntilChanged(\.isReadyToProceedWithSignUp)
            .map { $0.user }
            .withUnretained(self)
            .subscribe(onNext: { (this, user) in
                this.pushSignUpProfileViewController(with: user)
            })
            .disposed(by: disposeBag)
        
        navigationController.pushViewController(signUpAgreementViewController, animated: true)
    }
    
    private func pushSignUpProfileViewController(with user: UserAuthentification) {
        let signUpProfileCoordinator = SignUpProfileCoordinator(navigationController: navigationController, user: user)
        signUpProfileCoordinator.parentCoordinator = self
        childCoordinators.append(signUpProfileCoordinator)
        signUpProfileCoordinator.start()
    }
}
