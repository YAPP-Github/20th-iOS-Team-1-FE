//
//  AccountValidationRepositoryInterface.swift
//  App
//
//  Created by Hani on 2022/06/24.
//

import Foundation

import RxSwift

protocol AccountValidationRepositoryInterface {
    func validateDuplicationAndLength(nickname: String, accessToken: Data) -> Single<AccountValidation>
}
