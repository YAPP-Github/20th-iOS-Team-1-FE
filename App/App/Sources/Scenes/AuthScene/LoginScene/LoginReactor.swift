//
//  LoginReactor.swift
//  App
//
//  Created by Hani on 2022/05/01.
//

import AuthenticationServices
import Foundation

import ReactorKit
import RxSwift

final class LoginReactor: Reactor {
    enum Action {
        case signInWithApple(authorization: ASAuthorization)
    }
    
    enum Mutation {
    }
    
    struct State {
    }
    
    let initialState = State()
    
    private let disposeBag = DisposeBag()
    private let appleLoginRepository: AppleLoginRepositoryInterface
    private let keychainProvider: KeychainProvidable
    internal var readyToProceedWithSignUp = PublishSubject<Void>()
    
    init(appleLoginRepository: AppleLoginRepositoryInterface, keychainProvider: KeychainProvidable) {
        self.appleLoginRepository = appleLoginRepository
        self.keychainProvider = keychainProvider
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .signInWithApple(authorization: let authorization):
            signInWithApple(authorization: authorization)
            return Observable.empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        }
        
        return newState
    }
    
    private func signInWithApple(authorization: ASAuthorization) {
        guard let appleCrendential = getAppleCrendential(for: authorization) else {
            return
        }
        print(appleCrendential.identifier)
        appleLoginRepository.requestAppleLogin(appleCredential: appleCrendential)
            .subscribe { [weak self] result in
                switch result {
                case .success(let signInResult):
                    guard let accessToken = signInResult.accessToken.data(using: .utf8, allowLossyConversion: false),
                          let refreshToken = signInResult.refreshToken.data(using: .utf8, allowLossyConversion: false),
                          let identifier = appleCrendential.identifier.data(using: .utf8, allowLossyConversion: false) else {
                        return
                    }
                    
                    try? self?.keychainProvider.delete(service: KeychainService.apple, account: KeychainAccount.identifier)
                    print(11)
                    try? self?.keychainProvider.delete(service: KeychainService.apple, account: KeychainAccount.accessToken)
                    print(21)
                    try? self?.keychainProvider.delete(service: KeychainService.apple, account: KeychainAccount.refreshToken)
                    print(31)
                    try? self?.keychainProvider.create(accessToken, service: KeychainService.apple, account: KeychainAccount.accessToken)
                    print(41)
                    try? self?.keychainProvider.create(refreshToken, service: KeychainService.apple, account: KeychainAccount.refreshToken)
                    print(51)
                    try? self?.keychainProvider.create(identifier, service: KeychainService.apple, account: KeychainAccount.identifier)
                    print(61)
                    self?.readyToProceedWithSignUp.onNext(())
                    print(71)
                    
            case .failure(_):
                #warning("애플로그인 실패하면 예외처리")
            }
        }.disposed(by: self.disposeBag)
    }
    
    private func getAppleCrendential(for authorization: ASAuthorization) -> AppleCredential? {
        guard let crendential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let code = crendential.authorizationCode,
              let token = crendential.identityToken,
              let email = crendential.email else {
            return nil
        }
        
        let identifier = crendential.user
        let appleCredential = AppleCredential(authorizationCode: code, identityToken: token, email: email, identifier: identifier)
        
        return appleCredential
    }
}
