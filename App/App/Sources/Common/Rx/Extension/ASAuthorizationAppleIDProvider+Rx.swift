//
//  ASAuthorizationAppleIDProvider+Rx.swift
//  App
//
//  Created by Hani on 2022/05/22.
//

import AuthenticationServices
import Foundation

import RxCocoa
import RxSwift

extension Reactive where Base: ASAuthorizationAppleIDProvider {
    public func requestAuthorization(with scopes: [ASAuthorization.Scope], window: UIWindow) -> Observable<ASAuthorization> {
        let request = base.createRequest()
        request.requestedScopes = scopes
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        
        let delegateProxy = RxASAuthorizationControllerDelegateProxy.proxy(for: controller)
        controller.delegate = delegateProxy
        
        let presentationContextProviderProxy = RxASAuthorizationControllerPresentationContextProvidingProxy.proxy(for: controller)
        controller.presentationContextProvider = presentationContextProviderProxy
        
        controller.performRequests()
        
        return delegateProxy.event
    }
}
