//
//  PetTag.swift
//  App
//
//  Created by 김나희 on 7/16/22.
//

import Foundation

enum PetTag {
    case active
    case docile
    case sociable
    case independent
    case adaptable
    case inadaptable
    
    func toString() -> String {
        switch self {
        case .active:
            return "활발"
        case .docile:
            return "온순"
        case .sociable:
            return "사교적"
        case .independent:
            return "독립적"
        case .adaptable:
            return "능동적"
        case .inadaptable:
            return "신중함"
        }
    }
}
