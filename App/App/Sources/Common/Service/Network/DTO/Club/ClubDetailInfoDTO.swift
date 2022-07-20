//
//  ClubDetailInfoDTO.swift
//  App
//
//  Created by Hani on 2022/07/07.
//

import Foundation

struct ClubDetailInfoDTO: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
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
    
    let id: Int
    let title: String
    let description: String
    let category: String
    let meetingPlace: String
    let latitude: Double
    let longitude: Double
    let startDate: String
    let endDate: String
    let eligiblePetSizeTypes: [String]
    let eligibleBreeds: [String]
    let eligibleSex: String
    let maximumPeople: Int
    let participants: Int
    
    func toDomain() -> ClubDetailInfo {
        ClubDetailInfo(id: id,
                       title: title,
                       description: description,
                       category: category,
                       meetingPlace: meetingPlace,
                       latitude: latitude,
                       longitude: longitude,
                       startDate: startDate,
                       endDate: endDate,
                       eligiblePetSizeTypes: eligiblePetSizeTypes,
                       eligibleBreeds: eligibleBreeds,
                       eligibleSex: eligibleSex,
                       maximumPeople: maximumPeople,
                       participants: participants)
    }
}
