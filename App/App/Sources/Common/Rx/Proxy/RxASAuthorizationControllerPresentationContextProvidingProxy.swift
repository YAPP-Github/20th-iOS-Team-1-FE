//
//  RxASAuthorizationControllerPresentationContextProvidingProxy.swift
//  App
//
//  Created by Hani on 2022/05/22.
//

import AuthenticationServices
import Foundation

import RxCocoa
import RxSwift

final class RxASAuthorizationControllerPresentationContextProvidingProxy: DelegateProxy<ASAuthorizationController, ASAuthorizationControllerPresentationContextProviding>, DelegateProxyType {
    public init(controller: ASAuthorizationController) {
        super.init(parentObject: controller, delegateProxy: RxASAuthorizationControllerPresentationContextProvidingProxy.self)
    }
    
    public static func registerKnownImplementations() {
        register { RxASAuthorizationControllerPresentationContextProvidingProxy(controller: $0) }
    }
    
    static func currentDelegate(for object: ASAuthorizationController) -> ASAuthorizationControllerPresentationContextProviding? {
        return object.presentationContextProvider
    }
    
    static func setCurrentDelegate(_ presentationContextProvider: ASAuthorizationControllerPresentationContextProviding?, to object: ASAuthorizationController) {
        object.presentationContextProvider = presentationContextProvider
    }
}

extension RxASAuthorizationControllerPresentationContextProvidingProxy: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIWindow()
    }
}
