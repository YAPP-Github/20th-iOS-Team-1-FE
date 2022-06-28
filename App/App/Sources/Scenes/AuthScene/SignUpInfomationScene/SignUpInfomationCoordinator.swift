//
//  SignUpInfomationCoordinator.swift
//  App
//
//  Created by Hani on 2022/06/25.
//

import UIKit

import RxSwift

final class SignUpInfomationCoordinator: SceneCoordinator {
    private var user: UserAccount
    
    var parentCoordinator: SceneCoordinator?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController, user: UserAccount) {
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
                this.pushSignUpAreaViewController(with: user)
            })
            .disposed(by: disposeBag)
        
        navigationController.pushViewController(signUpInfomationViewController, animated: true)
    }
    
    private func pushSignUpAreaViewController(with user: UserAccount) {
        let signUpAreaCoordinator = SignUpAreaCoordinator(navigationController: navigationController, user: user)
        signUpAreaCoordinator.parentCoordinator = self
        childCoordinators.append(signUpAreaCoordinator)
        signUpAreaCoordinator.start()
    }
}