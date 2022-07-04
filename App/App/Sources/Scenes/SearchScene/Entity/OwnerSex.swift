//
//  OwnerSex.swift
//  App
//
//  Created by 유한준 on 2022/07/05.
//

import Foundation

enum OwnerSex: String {
    case man = "MAN"
    case woman = "WOMAN"
    case all = "ALL"
    
    internal func toKorean() -> String {
        switch self {
        case .man:
            return "남성 Only"
        case .woman:
            return "여성 Only"
        case .all:
            return "상관없음"
        }
    }
}
