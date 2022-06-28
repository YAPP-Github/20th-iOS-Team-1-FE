//
//  AA.swift
//  App
//
//  Created by Hani on 2022/06/28.
//

import UIKit

import RxSwift

final class AA: Coordinator {
    var childCoordinators = [Coordinator]()
    let navigationController = UINavigationController()
    var window: UIWindow?
    var disposeBag = DisposeBag()
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let networkManager = NetworkManager.shared
        let appleLoginRepository = AppleLoginRepository(networkManager: networkManager)
        let keychainProvider = KeychainProvider.shared
        let loginReactor = LoginReactor(appleLoginRepository: appleLoginRepository, keychainProvider: keychainProvider)
        let loginViewController = LoginViewController(reactor: loginReactor)
        
//        disposeBag.insert {
//            loginReactor.state
//                .distinctUntilChanged(\.isReadyToProceedWithSignUp)
//                .withUnretained(self)
//                .subscribe(onNext: { (owner, user) in
//                    owner.pushSignUpAgreementViewController()
//                })
//        }
//     

        navigationController.setViewControllers([loginViewController], animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    private func pushSignUpAgreementViewController() {
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
    
    private func pushSignUpProfileViewController(with user: UserAccount) {
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
    
    private func pushSignUpInfomationViewController(with user: UserAccount) {
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
}
