//
//  SignUpInfomationReactor.swift
//  App
//
//  Created by Hani on 2022/06/03.
//

import Foundation

import ReactorKit
import RxSwift

final class SignUpInfomationReactor: Reactor {
    enum Action {
        case nextButtonDidTap
    }
    
    enum Mutation {
        case readyToProceedWithSignUp
    }
    
    struct State {
        var isReadyToProceedWithSignUp = false
    }
    
    let initialState = State()
    var user: BehaviorSubject<UserAuthentification>
    
    init(user: UserAuthentification) {
        self.user = BehaviorSubject<UserAuthentification>(value: user)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .nextButtonDidTap:
            return Observable.just(Mutation.readyToProceedWithSignUp)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .readyToProceedWithSignUp:
            newState.isReadyToProceedWithSignUp = true
        }
        
        return newState
    }
}
