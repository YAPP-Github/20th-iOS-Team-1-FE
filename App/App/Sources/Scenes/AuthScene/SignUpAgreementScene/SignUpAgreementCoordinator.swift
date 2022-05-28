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

        navigationController.pushViewController(signUpAgreementViewController, animated: true)
    }
}
