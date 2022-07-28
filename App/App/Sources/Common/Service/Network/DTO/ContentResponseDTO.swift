//
//  ContentResponseDTO.swift
//  App
//
//  Created by Hani on 2022/07/07.
//

import Foundation

struct ContentResponseDTO: Codable {
    private enum CodingKeys: String, CodingKey {
        case clubID = "clubId"
        case title, category, meetingPlace, startDate, endDate, eligibleBreeds, eligiblePetSizeTypes, eligibleSex, maximumPeople, participants
    }
    
    internal let clubID: Int
    internal let title, category, meetingPlace: String
    internal let startDate, endDate: String
    internal let eligibleBreeds: [String]?
    internal let eligiblePetSizeTypes: [String]
    internal let eligibleSex: String
    internal let maximumPeople, participants: Int
    
    func toDomain() -> Content {
        let content = Content(clubID: clubID,
                              title: title,
                              category: category,
                              meetingPlace: meetingPlace,
                              startDate: startDate,
                              endDate: endDate,
                              eligibleBreeds: eligibleBreeds,
                              eligiblePetSizeTypes: eligiblePetSizeTypes,
                              eligibleSex: eligibleSex,
                              maximumPeople: maximumPeople,
                              participants: participants)
        
        return content
    }
}
