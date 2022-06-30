//
//  ProfileMainRepositoryInterface.swift
//  App
//
//  Created by 김나희 on 6/29/22.
//

import Foundation

import RxSwift

protocol ProfileMainRepositoryInterface {
    func requestProfileInfo(nickname: String) -> Single<ProfileInfo>
}
