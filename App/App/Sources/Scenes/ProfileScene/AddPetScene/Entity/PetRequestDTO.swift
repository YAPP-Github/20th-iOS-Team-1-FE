//
//  PetRequestDTO.swift
//  App
//
//  Created by 김나희 on 7/16/22.
//

import Foundation

struct PetRequestInfo {
    var name: String? = nil
    var year: Int = 0
    var month: Int = 0
    var breed: String? = nil
    var sex: SexDTO = .private
    var neutering: Bool = false
    var sizeType: PetSizeTypeDTO = .small
    var tags: [String]? = []
    var imageFile: Data?
}
