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
        case ageTextFieldDidEndEditing(String)
        case manButtonDidTap
        case womanButtonDidTap
        case privateSexButtonDidTap
        case nextButtonDidTap
    }
    
    enum Mutation {
        case updateAge(Int?)
        case selectMan
        case selectWoman
        case selectPrivateSex
        case activateNextButton(Bool)
        case readyToProceedWithSignUp
    }
    
    struct State {
        var user: UserAuthentification
        var isManSelected = false
        var isWomanSelected = false
        var isPrivateSexSelected = false
        var isNextButtonEnabled = false
        var isReadyToProceedWithSignUp = false
    }
    
    let initialState: State
    
    init(user: UserAuthentification) {
        initialState = State(user: user)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .ageTextFieldDidEndEditing(let age):
            return Observable.concat(
                [Observable.just(.updateAge(Int(age))),
                Observable.just(.activateNextButton(currentState.user.age != nil))
            ])
        case .manButtonDidTap:
            return Observable.concat([
                Observable.just(.selectMan),
                Observable.just(.activateNextButton(currentState.user.age != nil))
            ])
        case .womanButtonDidTap:
            return Observable.concat([
                Observable.just(.selectWoman),
                Observable.just(.activateNextButton(currentState.user.age != nil))
            ])
        case .privateSexButtonDidTap:
            return Observable.concat([
                Observable.just(.selectPrivateSex),
                Observable.just(.activateNextButton(currentState.user.age != nil))
            ])
        case .nextButtonDidTap:
            return Observable.just(.readyToProceedWithSignUp)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .updateAge(let age):
            newState.user.age = age
        case .selectMan:
            newState.isManSelected = true
            newState.isWomanSelected = false
            newState.isPrivateSexSelected = false
       case .selectWoman:
            newState.isManSelected = false
            newState.isWomanSelected = true
            newState.isPrivateSexSelected = false
        case .selectPrivateSex:
            newState.isManSelected = false
            newState.isWomanSelected = false
            newState.isPrivateSexSelected = true
        case .activateNextButton(let isEnabled):
            newState.isNextButtonEnabled = isEnabled
        case .readyToProceedWithSignUp:
            newState.isReadyToProceedWithSignUp = true
        }
        
        return newState
    }
}
