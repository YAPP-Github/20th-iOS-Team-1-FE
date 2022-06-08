//
//  SearchingClubDTO.swift
//  App
//
//  Created by Hani on 2022/06/08.
//

import Foundation

struct SearchingClubDTO: Codable {
    internal let category: CategoryDTO
    internal let title: String
    internal let startDate: String
    internal let endDate: String
    internal let eligiblePetSizeTypes: [PetSizeTypeDTO]
    internal let eligibleBreeds: [EligibleBreedDTO]
    internal let eligibleSex: EligibleSexDTO
    internal let maximumPeople: Int
    internal let participants: Int
    internal let leaderName: String
    internal let imagePath: String
    internal let latitude: Double
    internal let longitude: Double
    internal let mettingPlace: String
    
    enum CodingKeys: String, CodingKey {
        case category
        case title
        case startDate
        case endDate
        case eligiblePetSizeTypes
        case eligibleBreeds
        case eligibleSex
        case maximumPeople
        case participants
        case leaderName
        case imagePath
        case latitude
        case longitude
        case mettingPlace
    }
}
