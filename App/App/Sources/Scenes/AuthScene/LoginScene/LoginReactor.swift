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
        
        appleLoginRepository.requestAppleLogin(appleCredential: appleCrendential)
            .subscribe { [weak self] result in
                switch result {
                case .success(let signInResult):
                    if signInResult.firstAccount {
                        guard let accessToken = signInResult.accessToken.data(using: .utf8, allowLossyConversion: false),
                              let refreshToken = signInResult.refreshToken.data(using: .utf8, allowLossyConversion: false) else {
                            return
                        }
                    
                        try? self?.keychainProvider.create(accessToken, service: KeychainService.apple, account: KeychainAccount.accessToken)
                        try? self?.keychainProvider.create(refreshToken, service: KeychainService.apple, account: KeychainAccount.refreshToken)
                    }
                    
                    self?.readyToProceedWithSignUp.onNext(())
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
        
        let appleCredential = AppleCredential(authorizationCode: code, identityToken: token, email: email)
        
        return appleCredential
    }
}
