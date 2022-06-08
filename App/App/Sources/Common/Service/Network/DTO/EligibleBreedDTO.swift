//
//  EligibleBreedDTO.swift
//  App
//
//  Created by Hani on 2022/06/08.
//

import Foundation

enum EligibleBreedDTO: Codable {
    case maltese
    case welshCorgi
    case retriever
    case all
    
    enum CodingKeys: String, CodingKey {
        case maltese = "WALK"
        case welshCorgi = "WELSH_CORGI"
        case retriever = "RETRIEVER"
        case all = "ALL"
    }
}
