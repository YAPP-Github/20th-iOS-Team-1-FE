//
//  EditProfileRepositoryInterface.swift
//  App
//
//  Created by 김나희 on 7/14/22.
//

import Foundation

import RxSwift

protocol EditProfileRepositoryInterface {
    func editProfile(introduction: String, accessToken: Data) -> Single<Void>
}
