//
//  SignUpProfileCoordinator.swift
//  App
//
//  Created by Hani on 2022/06/02.
//

import UIKit

import RxSwift

final class SignUpProfileCoordinator: SceneCoordinator {
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
        let regularExpressionValidator = RegularExpressionValidator()
        let signUpProfileReactor = SignUpProfileReactor(user: user, regularExpressionValidator: regularExpressionValidator)
        let signUpProfileViewController = SignUpProfileViewController(reactor: signUpProfileReactor)

        navigationController.pushViewController(signUpProfileViewController, animated: true)
    }
}
