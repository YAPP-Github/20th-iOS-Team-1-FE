//
//  AccountInfo.swift
//  App
//
//  Created by 김나희 on 7/1/22.
//

import Foundation

struct AccountInfo: Equatable {
    let id: Int
    var nickName: String? = nil
    var address: String? = nil
    var age: String? = nil
    var sex: String? = nil
    var Introduction: String? = nil
    var categories: [String]?
    var profileImageURL: String?
}
