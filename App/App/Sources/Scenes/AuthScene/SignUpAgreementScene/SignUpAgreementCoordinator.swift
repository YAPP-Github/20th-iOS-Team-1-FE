//
//  SignUpAgreementCoordinator.swift
//  App
//
//  Created by Hani on 2022/05/24.
//

import UIKit

import RxSwift

final class SignUpAgreementCoordinator: SceneCoordinator {
    var parentCoordinator: SceneCoordinator?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let signUpAgreementReactor = SignUpAgreementReactor()
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
