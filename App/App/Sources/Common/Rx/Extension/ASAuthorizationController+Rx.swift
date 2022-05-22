//
//  ASAuthorizationController+Rx.swift
//  App
//
//  Created by Hani on 2022/05/22.
//
import AuthenticationServices
import Foundation

import RxCocoa
import RxSwift

extension Reactive where Base: ASAuthorizationController {
    var delegate: DelegateProxy<ASAuthorizationController, ASAuthorizationControllerDelegate> {
        return RxASAuthorizationControllerDelegateProxy.proxy(for: base)
    }
    
    var presentationContextProvider: DelegateProxy<ASAuthorizationController, ASAuthorizationControllerPresentationContextProviding> {
        return RxASAuthorizationControllerPresentationContextProvidingProxy.proxy(for: base)
    }
}
