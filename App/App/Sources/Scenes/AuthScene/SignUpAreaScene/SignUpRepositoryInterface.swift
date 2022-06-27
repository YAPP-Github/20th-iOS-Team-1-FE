//
//  SignUpRepositoryInterface.swift
//  App
//
//  Created by Hani on 2022/06/27.
//

import Foundation

import RxSwift 

protocol SignUpRepositoryInterface {
    func signUp(user: UserAccount, accessToken: Data) -> Single<Void>
}
