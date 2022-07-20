//
//  PetInfo.swift
//  App
//
//  Created by 김나희 on 7/1/22.
//

import Foundation

struct PetInfo: Equatable {
    let id: Int
    var nickName: String? = nil
    var breed: String? = nil
    var age: String? = nil
    var sex: String? = nil
    var tags: [String]?
    var imageURL: String?
}
