//
//  SignUpAccountDTO.swift
//  App
//
//  Created by Hani on 2022/06/27.
//

import Foundation

struct SignUpAccountDTO: Codable {
    private enum CodingKeys: String, CodingKey {
        case nickname
       // case imageFile
        case age
        case sex
        case city
        case detail
    }
    
    internal let nickname: String
   // internal let imageFile: Data?
    internal let age: Int
    internal let sex: String
    internal let city: String
    internal let detail: String
    
    init?(user: UserAccount) {
        guard let nickname = user.nickName,
              let age = user.age,
              let sex = user.sex,
              let city = user.bigCity,
              let detail = user.smallCity else {
            return nil
        }

        self.nickname = nickname
       // self.imageFile = user.profileImageData
        self.age = age
        self.sex = sex
        self.city = city
        self.detail = detail
    }
}
