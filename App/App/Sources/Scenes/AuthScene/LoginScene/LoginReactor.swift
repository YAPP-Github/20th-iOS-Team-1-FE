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
        case isLoggedIn
    }
    
    struct State {
        var isReadyToProceedWithSignUp = false
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .signInWithApple(authorization: let authorization):
            return Observable.just(Mutation.isLoggedIn)
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
    
    private func requestAppleLogin(for authorization: ASAuthorization) -> AppleCredential? {
        guard let crendential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let code = crendential.authorizationCode,
              let token = crendential.identityToken else {
            return nil
        }
        
        let appleCredential = AppleCredential(authorizationCode: code, identityToken: token)
        
        return appleCredential
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
