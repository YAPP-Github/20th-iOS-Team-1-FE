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
        case isLoggedIn(Bool)
    }
    
    struct State {
        var isReadyToProceedWithSignUp = false
    }
    
    let initialState = State()
    private let disposeBag = DisposeBag()
    private let appleLoginRepository: AppleLoginRepositoryInterface
    private let keychainProvider: KeychainProvidable
    
    init(appleLoginRepository: AppleLoginRepositoryInterface, keychainProvider: KeychainProvidable) {
        self.appleLoginRepository = appleLoginRepository
        self.keychainProvider = keychainProvider
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .signInWithApple(authorization: let authorization):
            return signInWithApple(authorization: authorization)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .isLoggedIn:
            newState.isReadyToProceedWithSignUp = true
        }
        
        return newState
    }
    
    private func signInWithApple(authorization: ASAuthorization) -> Observable<Mutation> {
        return Observable.create { [weak self] observer in
            guard let self = self,
                  let appleCrendential = self.getAppleCrendential(for: authorization) else {
                observer.onNext(Mutation.isLoggedIn(false))
                return Disposables.create()
            }
            
            self.appleLoginRepository.requestAppleLogin(appleCredential: appleCrendential)
                .subscribe { result in
                    switch result {
                    case .success(let signInResult):
                        if signInResult.firstAccount {
                            guard let accessToken = signInResult.accessToken.data(using: .utf8, allowLossyConversion: false),
                                  let refreshToken = signInResult.refreshToken.data(using: .utf8, allowLossyConversion: false) else {
                                observer.onNext(Mutation.isLoggedIn(false))
                                return 
                            }
                            
                            try? self.keychainProvider.create(accessToken, service: "appleLogin", account: "accessToken")
                            try? self.keychainProvider.create(refreshToken, service: "appleLogin", account: "refreshToken")
                        }
                        observer.onNext(Mutation.isLoggedIn(true))
                    case .failure(_):
                        observer.onNext(Mutation.isLoggedIn(false))
                    }
                }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    private func getAppleCrendential(for authorization: ASAuthorization) -> AppleCredential? {
        guard let crendential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let code = crendential.authorizationCode,
              let token = crendential.identityToken else {
            return nil
        }
        
        let appleCredential = AppleCredential(authorizationCode: code, identityToken: token)
        
        return appleCredential
    }
}
