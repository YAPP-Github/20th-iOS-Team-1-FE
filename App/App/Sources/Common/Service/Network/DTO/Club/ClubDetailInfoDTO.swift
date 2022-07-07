//
//  ClubDetailInfoDTO.swift
//  App
//
//  Created by Hani on 2022/07/07.
//

import Foundation

struct ClubDetailInfoDTO: Codable {
    private enum CodingKeys: String, CodingKey {
        case title
        case description
        case category
        case meetingPlace
        case latitude
        case longitude
        case startDate
        case endDate
        case eligiblePetSizeTypes
        case eligibleBreeds
        case eligibleSex
        case maximumPeople
        case participants
    }
    
    let title: String
    let description: String
    let category: String
    let meetingPlace: String
    let latitude: Double
    let longitude: Double
    let startDate: String
    let endDate: String
    let eligiblePetSizeTypes: [PetSizeTypeDTO]
    let eligibleBreeds: [EligibleBreedDTO]
    let eligibleSex: String
    let maximumPeople: Int
    let participants: Int
}


