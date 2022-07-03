//
//  AuthCoordinator.swift
//  App
//
//  Created by Hani on 2022/06/28.
//

import UIKit

import RxSwift

final class AuthCoordinator: SceneCoordinator {
    weak var delegate: AuthCoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()
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
 
        loginReactor.readyToProceedWithSignUp
            .asDriver(onErrorJustReturn: ())
            .drive(with: self,
                   onNext: { this, _ in
                this.pushSignUpAgreementViewController()
            })
            .disposed(by:disposeBag)
        
        navigationController.setViewControllers([loginViewController], animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func pushSignUpAgreementViewController() {
        let signUpAgreementReactor = SignUpAgreementReactor()
        let signUpAgreementViewController = SignUpAgreementViewController(reactor: signUpAgreementReactor)
        
        signUpAgreementReactor.readyToProceedWithSignUp
            .asDriver(onErrorJustReturn: UserAccount())
            .drive(with: self,
                   onNext: { this, user in
                this.pushSignUpProfileViewController(with: user)
            })
            .disposed(by:disposeBag)
        
        signUpAgreementReactor.readyToShowTermsOfService
            .asDriver(onErrorJustReturn: ())
            .drive(with: self,
                   onNext: { this, _ in
                this.pushSignUpTermsOfServiceViewController()
            })
            .disposed(by:disposeBag)
        
        signUpAgreementReactor.readyToShowPrivacyPolicy
            .asDriver(onErrorJustReturn: ())
            .drive(with: self,
                   onNext: { this, _ in
                this.pushSignUpPrivacyPolicyViewController()
            })
            .disposed(by:disposeBag)
        
        navigationController.pushViewController(signUpAgreementViewController, animated: true)
    }
    
    func pushSignUpTermsOfServiceViewController() {
        let signUpTermsOfServiceViewController = SignUpTermsOfServiceViewController()
        
        navigationController.present(signUpTermsOfServiceViewController, animated: true)
    }
    
    func pushSignUpPrivacyPolicyViewController() {
        let signUpPrivacyPolicyViewController = SignUpPrivacyPolicyViewController()
        
        navigationController.present(signUpPrivacyPolicyViewController, animated: true)
    }
    
    func pushSignUpProfileViewController(with user: UserAccount) {
        let networkManager = NetworkManager.shared
        let accountValidationRepository = AccountValidationRepository(networkManager: networkManager)
        let keychain = KeychainQueryRequester()
        let keychainProvider = KeychainProvider(keyChain: keychain)
        let keychainUseCase = KeychainUsecase(keychainProvider: keychainProvider, networkManager: networkManager)
        let regularExpressionValidator = RegularExpressionValidator()
        let signUpProfileReactor = SignUpProfileReactor(user: user, regularExpressionValidator: regularExpressionValidator, accountValidationRepository: accountValidationRepository, keychainUseCase: keychainUseCase)
        let signUpProfileViewController = SignUpProfileViewController(reactor: signUpProfileReactor)
        
        signUpProfileReactor.readyToProceedWithSignUp
            .asDriver(onErrorJustReturn: (UserAccount()))
            .drive(with: self,
                   onNext: { this, user in
                this.pushSignUpInfomationViewController(with: user)
            })
            .disposed(by:disposeBag)
        
        navigationController.pushViewController(signUpProfileViewController, animated: true)
    }
    
    func pushSignUpInfomationViewController(with user: UserAccount) {
        let signUpInfomationReactor = SignUpInfomationReactor(user: user)
        let signUpInfomationViewController = SignUpInfomationViewController(reactor: signUpInfomationReactor)
        
        signUpInfomationReactor.readyToProceedWithSignUp
            .asDriver(onErrorJustReturn: UserAccount())
            .drive(with: self,
                   onNext: { this, user in
                this.pushSignUpAreaViewController(with: user)
            })
            .disposed(by:disposeBag)
        
        navigationController.pushViewController(signUpInfomationViewController, animated: true)
    }
    
    func pushSignUpAreaViewController(with user: UserAccount) {
        let networkManager = NetworkManager.shared
        let signUpRepository = SignUpRepository(networkManager: networkManager)
        let keychain = KeychainQueryRequester()
        let keychainProvider = KeychainProvider(keyChain: keychain)
        let keychainUseCase = KeychainUsecase(keychainProvider: keychainProvider, networkManager: networkManager)
        let signUpAreaReactor = SignUpAreaReactor(user: user, keychainUseCase: keychainUseCase, signUpRepository: signUpRepository)
        let signUpAreaViewController = SignUpAreaViewController(reactor: signUpAreaReactor)

        signUpAreaReactor.readyToStart
            .asDriver(onErrorJustReturn: ())
            .drive(with: self,
                   onNext: { this, user in
                this.delegate?.switchToTabBar()
            })
            .disposed(by:disposeBag)
        
        navigationController.pushViewController(signUpAreaViewController, animated: true)
    }
}

protocol AuthCoordinatorDelegate: AnyObject {
    func switchToTabBar()
}
