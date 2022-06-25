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
        let networkManager = NetworkManager.shared
        let accountValidationRepository = AccountValidationRepository(networkManager: networkManager)
        let keychain = KeychainQueryRequester()
        let keychainProvider = KeychainProvider(keyChain: keychain)
        let keychainUseCase = KeychainUsecase(keychainProvider: keychainProvider, networkManager: networkManager)
        let regularExpressionValidator = RegularExpressionValidator()
        let signUpProfileReactor = SignUpProfileReactor(user: user, regularExpressionValidator: regularExpressionValidator, accountValidationRepository: accountValidationRepository, keychainUseCase: keychainUseCase)
        let signUpProfileViewController = SignUpProfileViewController(reactor: signUpProfileReactor)

        signUpProfileReactor.state
            .distinctUntilChanged(\.isReadyToProceedWithSignUp)
            .map { $0.user }
            .withUnretained(self)
            .subscribe(onNext: { (this, user) in
                this.pushSignUpInfomationViewController(with: user)
            })
            .disposed(by: disposeBag)
        
        navigationController.pushViewController(signUpProfileViewController, animated: true)
    }
    
    private func pushSignUpInfomationViewController(with user: UserAuthentification) {
        let signUpInfomationCoordinator = SignUpInfomationCoordinator(navigationController: navigationController, user: user)
        signUpInfomationCoordinator.parentCoordinator = self
        childCoordinators.append(signUpInfomationCoordinator)
        signUpInfomationCoordinator.start()
    }
}
