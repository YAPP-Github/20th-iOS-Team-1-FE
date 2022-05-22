//
//  LoginReactor.swift
//  App
//
//  Created by Hani on 2022/05/01.
//

import Foundation

import ReactorKit
import RxSwift

final class LoginReactor: Reactor {
    enum Action {
        case signInWithApple(email: String)
    }
    
    enum Mutation {
        case change(email: String)
    }
    
    struct State {
        var email = String()
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .signInWithApple(let email):
            return Observable.just(Mutation.change(email: email))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .change(let email):
            newState.email = email
        }
        
        return newState
    }
}
