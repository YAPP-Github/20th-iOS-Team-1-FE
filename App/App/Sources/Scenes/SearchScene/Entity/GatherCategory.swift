//
//  GatherCategory.swift
//  App
//
//  Created by 유한준 on 2022/06/04.
//

import Foundation

enum GatherCategory: String, Codable {
    case walk = "WALK"
    case playground = "PLAY_GROUND"
    case dogCafe = "DOG_CAFE"
    case dogRestaurant = "DOG_FRIENDLY_RESTAURANT"
    case exhibition = "EXPOSITION"
    case etc = "ETC"
    
    internal var korean: String {
        switch self {
        case .walk:
            return "산책"
        case .playground:
            return "놀이터"
        case .dogCafe:
            return "애견 카페"
        case .dogRestaurant:
            return "애견동반식당"
        case .exhibition:
            return "박람회"
        case .etc:
            return "기타"
        }
    }
}
