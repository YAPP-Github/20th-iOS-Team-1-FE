//
//  PetSizeType.swift
//  App
//
//  Created by 유한준 on 2022/07/05.
//

import Foundation

enum PetSizeType: String {
    case large = "LARGE"
    case medium = "MEDIUM"
    case small =  "SMALL"
    case all = "ALL"
    
    internal func toKorean() -> String {
        switch self {
        case .large:
            return "대형견"
        case .medium:
            return "중형견"
        case .small:
            return "소형견"
        case .all:
            return "상관없음"
        }
    }
}
