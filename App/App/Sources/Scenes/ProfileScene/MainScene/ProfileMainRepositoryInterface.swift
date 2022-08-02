//
//  ProfileMainRepositoryInterface.swift
//  App
//
//  Created by 김나희 on 6/29/22.
//

import Foundation

import RxSwift

protocol ProfileMainRepositoryInterface {
    func requestProfileInfo(accessToken: Data, nickname: String?) -> Single<ProfileInfo>
    func deletePet(accessToken: Data, id: Int) -> Single<Void>
    func withdraw(accessToken: Data) -> Single<Void>
    func logout(accessToken: Data) -> Single<Void>
}
