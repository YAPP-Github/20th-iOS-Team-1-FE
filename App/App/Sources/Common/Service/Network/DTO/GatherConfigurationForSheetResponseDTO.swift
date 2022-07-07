//
//  GatherConfigurationForSheetResponseDTO.swift
//  App
//
//  Created by 김나희 on 7/5/22.
//

import Foundation

struct GatherConfigurationForSheetResponseDTO: Codable {
    let category: String
    let title: String
    let startDate: String
    let endDate: String
    let eligibleBreeds: [String]
    let eligiblePetSizeTypes: [String]
    let eligibleSex: String
    var maximumPeople: Int
    var participants: Int
    let latitude: Double
    let longitude: Double
    let meetingPlace: String
    let distance: Int
    let clubStatus: String
    
    func toDomain() -> GatherConfigurationForSheet {
        return GatherConfigurationForSheet(
            category: category,
            title: title,
            meetingPlace: meetingPlace,
            startDate: startDate,
            endDate: endDate,
            eligileBreeds: eligibleBreeds,
            eligiblePetSizeTypes: eligiblePetSizeTypes,
            eligibleSex: eligibleSex,
            maximumPeople: maximumPeople,
            participants: participants,
            distance: distance,
            clubStatus: clubStatus
        )
    }
}
