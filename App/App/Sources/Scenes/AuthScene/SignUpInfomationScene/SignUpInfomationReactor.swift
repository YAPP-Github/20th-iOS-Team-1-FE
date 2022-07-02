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
    }
    
    struct State {
        var user: UserAccount
        var isManSelected = false
        var isWomanSelected = false
        var isPrivateSexSelected = false
        var isNextButtonEnabled = false
    }
    
    let initialState: State
    
    internal var readyToProceedWithSignUp = PublishSubject<UserAccount>()
    
    init(user: UserAccount) {
        initialState = State(user: user)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .ageTextFieldDidEndEditing(let age):
            return Observable.just(.updateAge(Int(age)))
        case .manButtonDidTap:
            return Observable.just(.selectMan)
        case .womanButtonDidTap:
            return Observable.just(.selectWoman)
        case .privateSexButtonDidTap:
            return Observable.just(.selectPrivateSex)
        case .nextButtonDidTap:
            readyToProceedWithSignUp.onNext(currentState.user)
            return Observable.empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .updateAge(let age):
            newState.user.age = age
            newState.isNextButtonEnabled = newState.user.age != nil && (newState.isManSelected || newState.isWomanSelected || newState.isPrivateSexSelected)
        case .selectMan:
            newState.user.sex = Sex.man
            newState.isManSelected = true
            newState.isWomanSelected = false
            newState.isPrivateSexSelected = false
            newState.isNextButtonEnabled = newState.user.age != nil && (newState.isManSelected || newState.isWomanSelected || newState.isPrivateSexSelected)
        case .selectWoman:
            newState.user.sex = Sex.woman
            newState.isManSelected = false
            newState.isWomanSelected = true
            newState.isPrivateSexSelected = false
            newState.isNextButtonEnabled = newState.user.age != nil && (newState.isManSelected || newState.isWomanSelected || newState.isPrivateSexSelected)
        case .selectPrivateSex:
            newState.user.sex = Sex.private
            newState.isManSelected = false
            newState.isWomanSelected = false
            newState.isPrivateSexSelected = true
            newState.isNextButtonEnabled = newState.user.age != nil && (newState.isManSelected || newState.isWomanSelected || newState.isPrivateSexSelected)
        }
        
        return newState
    }
}
