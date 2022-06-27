//
//  SignUpAreaCoordinator.swift
//  App
//
//  Created by Hani on 2022/06/26.
//
import UIKit

import RxSwift

final class SignUpAreaCoordinator: SceneCoordinator {
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
        let networkManager = NetworkManager.shared
        let signUpRepository = SignUpRepository(networkManager: networkManager)
        let keychain = KeychainQueryRequester()
        let keychainProvider = KeychainProvider(keyChain: keychain)
        let keychainUseCase = KeychainUsecase(keychainProvider: keychainProvider, networkManager: networkManager)
        let signUpAreaReactor = SignUpAreaReactor(user: user, keychainUseCase: keychainUseCase, signUpRepository: signUpRepository)
        let signUpAreaViewController = SignUpAreaViewController(reactor: signUpAreaReactor)
        
        signUpAreaReactor.state
            .distinctUntilChanged(\.isReadyToStartTogaether)
            .withUnretained(self)
            .subscribe(onNext: { (this, user) in
                
            })
            .disposed(by: disposeBag)
        
        navigationController.pushViewController(signUpAreaViewController, animated: true)
    }
    
    private func startTogaether() {
        
    }
}
