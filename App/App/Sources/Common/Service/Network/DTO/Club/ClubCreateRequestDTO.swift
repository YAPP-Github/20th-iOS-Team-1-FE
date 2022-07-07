//
//  ClubCreateRequestDTO.swift
//  App
//
//  Created by Hani on 2022/07/08.
//

import Foundation

struct ClubCreateRequestDTO: Codable {
    private enum CodingKeys: String, CodingKey {
        case meetingPlace
        case category
        case title
        case description
        case startDate
        case endDate
        case maximumPeople
        case eligibleSex
        case eligiblePetSizeTypes
        case eligibleBreeds
        case latitude
        case longitude
    }
    
    let meetingPlace: String
    let category: CategoryDTO
    let title: String
    let description: String
    let startDate: String
    let endDate: String
    let maximumPeople: Int
    let eligibleSex: EligibleSexDTO
    let eligiblePetSizeTypes: [PetSizeTypeDTO]
    let eligibleBreeds: [EligibleBreedDTO]
    let latitude: Double
    let longitude: Double
}
