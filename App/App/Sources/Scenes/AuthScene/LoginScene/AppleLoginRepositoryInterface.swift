//
//  AppleLoginRepositoryInterface.swift
//  App
//
//  Created by Hani on 2022/06/16.
//

import Foundation

import RxSwift

protocol AppleLoginRepositoryInterface {
    func requestAppleLogin(appleCredential: AppleCredential) -> Single<SignInResult>
}
