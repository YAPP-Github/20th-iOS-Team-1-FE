//
//  KeychainUseCaseInterface.swift
//  App
//
//  Created by Hani on 2022/06/24.
//

import Foundation

import RxSwift

protocol KeychainUseCaseInterface {
    func getAccessToken() -> Single<Data>
}
