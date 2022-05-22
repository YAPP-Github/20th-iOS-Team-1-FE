//
//  ASAuthorizationAppleIDButton+Rx.swift
//  App
//
//  Created by Hani on 2022/05/22.
//

import AuthenticationServices
import Foundation

import RxCocoa
import RxSwift

extension Reactive where Base: ASAuthorizationAppleIDButton {
    public func didTap(scopes: [ASAuthorization.Scope]) -> Observable<ASAuthorization> {
        return controlEvent(.touchUpInside)
            .flatMap {
                ASAuthorizationAppleIDProvider().rx.requestAuthorization(with: scopes, window: base.window!)
            }
    }
}
