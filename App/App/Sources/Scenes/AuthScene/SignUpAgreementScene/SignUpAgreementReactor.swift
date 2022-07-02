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
    }
    
    struct State {
        let user = UserAccount()
        var isAgreementChecked = false
        var isTermsOfServiceChecked = false
        var isPrivacyPolicyChecked = false
    }
    
    let initialState: State
    
    internal var readyToProceedWithSignUp = PublishSubject<UserAccount>()
    internal var readyToShowTermsOfService = PublishSubject<Void>()
    internal var readyToShowPrivacyPolicy = PublishSubject<Void>()
    
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
            return Observable.empty()
        case .privacyPolicyCheckBoxDidTap:
            return Observable.concat([
                Observable.just(.togglePrivacyPolicy),
                Observable.just(.syncAgreementWithTermsOfServiceAndPrivacyPolicy)
            ])
        case .termsOfServiceLabelDidTap:
            readyToShowTermsOfService.onNext(())
            return Observable.empty()
        case .privacyPolicyLabelDidTap:
            readyToShowPrivacyPolicy.onNext(())
            return Observable.empty()
        case .nextButtonDidTap:
            readyToProceedWithSignUp.onNext((currentState.user))
            return Observable.empty()
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
        }
        
        return newState
    }
}
