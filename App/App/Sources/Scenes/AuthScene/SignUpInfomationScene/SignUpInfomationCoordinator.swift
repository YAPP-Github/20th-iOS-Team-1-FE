//
//  SignUpInfomationCoordinator.swift
//  App
//
//  Created by Hani on 2022/06/25.
//

import UIKit

import RxSwift

final class SignUpInfomationCoordinator: SceneCoordinator {
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
        let signUpInfomationReactor = SignUpInfomationReactor(user: user)
        let signUpInfomationViewController = SignUpInfomationViewController(reactor: signUpInfomationReactor)

        signUpInfomationReactor.state
            .distinctUntilChanged(\.isReadyToProceedWithSignUp)
            .map { $0.user }
            .withUnretained(self)
            .subscribe(onNext: { (this, user) in
                this.pushSignUpInfomationViewController(with: user)
            })
            .disposed(by: disposeBag)
        
        navigationController.pushViewController(signUpInfomationViewController, animated: true)
    }
    
    private func pushSignUpInfomationViewController(with user: UserAuthentification) { } // willMoveToSignUpArea
}
