//
//  UserAuthentification.swift
//  App
//
//  Created by Hani on 2022/05/28.
//

import Foundation

struct UserAccount: Equatable {
    var profileImageData: Data? = nil
    var nickName: String? = nil
    var age: Int? = nil
    var sex: String?
    var bigCity: String?
    var smallCity: String?
}
