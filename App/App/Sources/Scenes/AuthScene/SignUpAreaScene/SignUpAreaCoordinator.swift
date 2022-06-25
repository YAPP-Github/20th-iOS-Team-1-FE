//
//  SignUpAreaCoordinator.swift
//  App
//
//  Created by Hani on 2022/06/26.
//
import UIKit

import RxSwift

final class SignUpAreaCoordinator: SceneCoordinator {
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
        let signUpAreaReactor = SignUpAreaReactor(user: user)
        let signUpAreaViewController = SignUpAreaViewController(reactor: signUpAreaReactor)

        navigationController.pushViewController(signUpAreaViewController, animated: true)
    }
    
}
