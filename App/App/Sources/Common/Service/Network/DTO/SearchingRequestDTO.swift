//
//  SearchingRequestDTO.swift
//  App
//
//  Created by Hani on 2022/06/08.
//

import Foundation

struct SearchingRequestDTO: Codable {
    internal let searchingWord: String
    internal let category: CategoryDTO
    internal let eligibleBreed: EligibleBreedDTO
    internal let petSizeType: PetSizeTypeDTO
    internal let eligibleSex: EligibleSexDTO
    internal let participateMin: Int
    internal let participateMax: Int
    internal let page: Int
    internal let startLatitude: Double
    internal let startLongitude: Double
    internal let status: StatusDTO
    
    enum CodingKeys: String, CodingKey {
        case searchingWord
        case category
        case eligibleBreed
        case petSizeType
        case eligibleSex
        case participateMin
        case participateMax
        case page
        case startLatitude
        case startLongitude
        case status
    }
}
