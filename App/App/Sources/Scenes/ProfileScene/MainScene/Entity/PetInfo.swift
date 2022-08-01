//
//  PetInfo.swift
//  App
//
//  Created by 김나희 on 7/1/22.
//

import Foundation
import UIKit

struct PetInfo: Equatable {
    var id: Int
    var nickName: String
    var breed: String
    var age: String
    var sex: PetGender
    var tags: [String]?
    var imageURL: String?
}

enum PetGender: String {
    case male = "MALE"
    case female = "FEMALE"
    
    func genderImage() -> UIImage {
        switch self {
        case .male:
            return .Togaether.genderSignMalePuppy
        case .female:
            return .Togaether.genderSignFemalePuppy
        }
    }
}
