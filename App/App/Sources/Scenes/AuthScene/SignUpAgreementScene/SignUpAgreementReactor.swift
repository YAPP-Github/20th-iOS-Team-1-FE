//
//  SignUpAgreementReactor.swift
//  App
//
//  Created by Hani on 2022/05/24.
//

import Foundation

import ReactorKit
import RxSwift

final class SignUpAgreementReactor: Reactor {
    enum Action {
        case agreementCheckBoxDidTap
        case termsOfServiceCheckBoxDidTap
        case termsOfServiceLabelDidTap
        case privacyPolicyCheckBoxDidTap
        case privacyPolicyLabelDidTap
        case nextButtonDidTap
    }
    
    enum Mutation {
        case toggleAgreement
        case toggleTermsOfService
        case togglePrivacyPolicy
        case syncAgreementWithTermsOfServiceAndPrivacyPolicy
        case syncTermsOfServiceAndPrivacyPolicyWithAgreement
        case readyToProceedWithSignUp
        case readyToShowTermsOfService
        case readyToShowPrivacyPolicy
    }
    
    struct State {
        let user = UserAccount()
        var isAgreementChecked = false
        var isTermsOfServiceChecked = false
        var isPrivacyPolicyChecked = false
        var isReadyToProceedWithSignUp = false
        var isReadyToShowTermsOfService = false
        var isReadyToShowPrivacyPolicy = false
    }
    
    let initialState: State
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .agreementCheckBoxDidTap:
            return Observable.concat([
                Observable.just(.toggleAgreement),
                Observable.just(.syncTermsOfServiceAndPrivacyPolicyWithAgreement)
            ])
        case .termsOfServiceCheckBoxDidTap:
            return Observable.concat([
                Observable.just(.toggleTermsOfService),
                Observable.just(.syncAgreementWithTermsOfServiceAndPrivacyPolicy)
            ])
        case .termsOfServiceLabelDidTap:
            return Observable.just(Mutation.readyToShowTermsOfService)
        case .privacyPolicyCheckBoxDidTap:
            return Observable.concat([
                Observable.just(.togglePrivacyPolicy),
                Observable.just(.syncAgreementWithTermsOfServiceAndPrivacyPolicy)
            ])
        case .privacyPolicyLabelDidTap:
            return Observable.just(Mutation.readyToShowPrivacyPolicy)
        case .nextButtonDidTap:
            return Observable.just(.readyToProceedWithSignUp)
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
        case .readyToShowTermsOfService:
            newState.isReadyToShowTermsOfService = true
        case .readyToShowPrivacyPolicy:
            newState.isReadyToShowPrivacyPolicy = true
        }
        
        return newState
    }
}
