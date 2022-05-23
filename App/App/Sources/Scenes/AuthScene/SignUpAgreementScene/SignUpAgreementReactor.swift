//
//  SignUpAgreementReactor.swift
//  App
//
//  Created by Hani on 2022/05/24.
//

import UIKit

import ReactorKit
import RxSwift

final class SignUpAgreementReactor: Reactor {
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        var email = String()
    }
    
    let initialState: State
    
    init(component: String) {
        initialState = State(email: component)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
            
        }
        
        return newState
    }
}
