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
        case agreementCheckBoxDidTap
        case termsOfServiceCheckBoxDidTap
        case privacyPolicyCheckBoxDidTap
        case nextButtonDidTap
    }
    
    enum Mutation {
        case toggleAgreement
        case toggleTermsOfService
        case togglePrivacyPolicy
        case syncAgreementWithTermsOfServiceAndPrivacyPolicy
        case syncTermsOfServiceAndPrivacyPolicyWithAgreement
        case readyToProceedWithSignUp
    }
    
    struct State {
        let email: String
        var isAgreementChecked = false
        var isTermsOfServiceChecked = false
        var isPrivacyPolicyChecked = false
        var isReadyToProceedWithSignUp = false
    }
    
    let initialState: State
    
    init(component: String) {
        self.initialState = State(email: component)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .agreementCheckBoxDidTap:
            return Observable.concat([
                Observable.just(Mutation.toggleAgreement),
                Observable.just(Mutation.syncTermsOfServiceAndPrivacyPolicyWithAgreement)
            ])
        case .termsOfServiceCheckBoxDidTap:
            return Observable.concat([
                Observable.just(Mutation.toggleTermsOfService),
                Observable.just(Mutation.syncAgreementWithTermsOfServiceAndPrivacyPolicy)
            ])
        case .privacyPolicyCheckBoxDidTap:
            return Observable.concat([
                Observable.just(Mutation.togglePrivacyPolicy),
                Observable.just(Mutation.syncAgreementWithTermsOfServiceAndPrivacyPolicy)
            ])
        case .nextButtonDidTap:
            return Observable.just(Mutation.readyToProceedWithSignUp)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .toggleAgreement:
            newState.isAgreementChecked.toggle()
        case .toggleTermsOfService:
            newState.isTermsOfServiceChecked.toggle()
        case .togglePrivacyPolicy:
            newState.isPrivacyPolicyChecked.toggle()
        case .syncAgreementWithTermsOfServiceAndPrivacyPolicy:
            newState.isAgreementChecked = newState.isTermsOfServiceChecked && newState.isPrivacyPolicyChecked
        case .syncTermsOfServiceAndPrivacyPolicyWithAgreement:
            newState.isTermsOfServiceChecked = newState.isAgreementChecked
            newState.isPrivacyPolicyChecked = newState.isAgreementChecked
        case .readyToProceedWithSignUp:
            newState.isReadyToProceedWithSignUp = true
        }
        
        return newState
    }
}
