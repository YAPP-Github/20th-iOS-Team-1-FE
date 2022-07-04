//
//  GatherListResponseDTO.swift
//  App
//
//  Created by 김나희 on 7/5/22.
//

import Foundation

struct GatherListResponseDTO: Codable {
    internal let hasNotClub: Bool
    internal let clubInfos: ClubInfosResponseDTO
    
    func toDomain() -> GatherListInfo {
        let gatherListInfo = GatherListInfo(hasNotClub: hasNotClub, clubInfos: clubInfos.toDomain())
        
        return gatherListInfo
    }
}

struct ClubInfosResponseDTO: Codable {
    internal let content: [ContentResponseDTO]
    internal let totalElements, totalPages: Int
    internal let last: Bool
    internal let size, number: Int
    internal let numberOfElements: Int
    internal let first, empty: Bool
    
    func toDomain() -> ClubInfos {
        let clubInfos = ClubInfos(content: content.map { element in
                                                element.toDomain() },
                                  totalElements: totalElements, totalPages: totalPages, last: last, size: size, number: number, numberOfElements: numberOfElements, first: first, empty: empty)
        
        return clubInfos
    }
}

struct ContentResponseDTO: Codable {
    internal let clubID: Int
    internal let title, category, meetingPlace: String?
    internal let startDate, endDate: String?
    internal let eligibleBreeds: [String]?
    internal let eligiblePetSizeTypes: [String]?
    internal let eligibleSex: String?
    internal let maximumPeople, participants: Int
    
    func toDomain() -> Content {
        let content = Content(clubID: clubID, title: title, category: category, meetingPlace: meetingPlace, startDate: startDate, endDate: endDate, eligibleBreeds: eligibleBreeds, eligiblePetSizeTypes: eligiblePetSizeTypes, eligibleSex: eligibleSex, maximumPeople: maximumPeople, participants: participants)
        
        return content
    }

    enum CodingKeys: String, CodingKey {
        case clubID = "clubId"
        case title, category, meetingPlace, startDate, endDate, eligibleBreeds, eligiblePetSizeTypes, eligibleSex, maximumPeople, participants
    }
}

struct Pageable: Codable {
    let sort: Sort
    let offset, pageNumber, pageSize: Int
    let paged, unpaged: Bool
}

struct Sort: Codable {
    let empty, unsorted, sorted: Bool
}
