//
//  PetRequestDTO.swift
//  App
//
//  Created by 김나희 on 7/16/22.
//

import Foundation

struct PetRequestInfo {
    var name: String? = nil
    var year: Int?
    var month: Int?
    var breed: String? = nil
    var sex: String?
    var neutering: Bool?
    var sizeType: String?
    var tags: [String]? = []
    var imageFile: Data?
}
