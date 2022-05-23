//
//  SignUpAgreementCoordinator.swift
//  App
//
//  Created by Hani on 2022/05/24.
//

import UIKit

import RxSwift

final class SignUpAgreementCoordinator: SceneCoordinator {
    private var component: String
    
    var parentCoordinator: SceneCoordinator?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController, component: String) {
        self.navigationController = navigationController
        self.component = component
    }
    
    func start() {
        let signUpAgreementReactor = SignUpAgreementReactor(component: component)
        let signUpAgreementViewController = SignUpAgreementViewController(reactor: signUpAgreementReactor)

        navigationController.pushViewController(signUpAgreementViewController, animated: true)
    }
}
