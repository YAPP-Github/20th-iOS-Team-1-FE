//
//  UserAuthentification.swift
//  App
//
//  Created by Hani on 2022/05/28.
//

import Foundation

struct UserAuthentification {
    var email: String? = nil
    var profileImageData: Data? = nil
    var nickName: String? = nil
}

extension UserAuthentification: Equatable { }
