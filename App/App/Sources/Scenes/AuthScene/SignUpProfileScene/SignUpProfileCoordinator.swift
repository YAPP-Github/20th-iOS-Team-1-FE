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

        navigationController.pushViewController(signUpProfileViewController, animated: true)
    }
}
