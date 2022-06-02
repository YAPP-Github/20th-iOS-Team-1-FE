//
//  SignUpProfileReactor.swift
//  App
//
//  Created by Hani on 2022/05/28.
//

import UIKit

import ReactorKit
import RxSwift

final class SignUpProfileReactor: Reactor {
    enum Action {
        case textFieldDidEndEditing(String)
        case duplicateCheckButtonDidTap
        case nextButtonDidTap
    }
    
    enum Mutation {
        case checkValidation(String)
        case checkDuplication
        case readyToProceedWithSignUp
    }
    
    struct State {
        var user: UserAuthentification
        var isNicknameValidationCheckDone = false
        var isNicknameDuplicateCheckDone = false
        var isReadyToProceedWithSignUp = false
    }
    
    private let regularExpressionValidator: RegularExpressionValidatable
    let initialState: State
    
    init(user: UserAuthentification, regularExpressionValidator: RegularExpressionValidatable) {
        self.initialState = State(user: user)
        self.regularExpressionValidator = regularExpressionValidator
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .textFieldDidEndEditing(let nickname):
            return Observable.just(Mutation.checkValidation(nickname))
        case .duplicateCheckButtonDidTap:
            return Observable.just(Mutation.checkDuplication)
        case .nextButtonDidTap:
            return Observable.just(Mutation.readyToProceedWithSignUp)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .checkValidation(let nickname):
            let isValid = regularExpressionValidator.validate(nickname: nickname)
            if isValid {
                newState.user.nickName = nickname
            } else {
                newState.user.nickName = nil
            }
            
            newState.isNicknameValidationCheckDone = isValid
        case .checkDuplication:
            newState.isNicknameDuplicateCheckDone = true
        case .readyToProceedWithSignUp:
            newState.isReadyToProceedWithSignUp = true
        }
        
        return newState
    }
}
