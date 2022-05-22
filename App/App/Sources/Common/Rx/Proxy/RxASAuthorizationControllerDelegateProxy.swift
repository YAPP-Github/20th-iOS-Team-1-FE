//
//  RxASAuthorizationControllerDelegateProxy.swift
//  App
//
//  Created by Hani on 2022/05/22.
//

import AuthenticationServices
import Foundation

import RxCocoa
import RxSwift

final class RxASAuthorizationControllerDelegateProxy: DelegateProxy<ASAuthorizationController, ASAuthorizationControllerDelegate>, DelegateProxyType {
    public lazy var event = PublishSubject<ASAuthorization>()
    
    public init(controller: ASAuthorizationController) {
        super.init(parentObject: controller, delegateProxy: RxASAuthorizationControllerDelegateProxy.self)
    }
    
    public static func registerKnownImplementations() {
        register { RxASAuthorizationControllerDelegateProxy(controller: $0) }
    }
    
    static func currentDelegate(for object: ASAuthorizationController) -> ASAuthorizationControllerDelegate? {
        return object.delegate
    }
    
    static func setCurrentDelegate(_ delegate: ASAuthorizationControllerDelegate?, to object: ASAuthorizationController) {
        object.delegate = delegate
    }
  
    deinit {
        event.onCompleted()
    }
}

extension RxASAuthorizationControllerDelegateProxy: ASAuthorizationControllerDelegate {
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        event.onNext(authorization)
        event.onCompleted()
    }

    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        event.onError(error)
    }
}
