//
//  Gather.swift
//  App
//
//  Created by 유한준 on 2022/06/04.
//

import Foundation
import CoreLocation

struct GatherConfigurationForAnnotation: Codable, Equatable {
    internal let id: Int
    internal let coordinate: Coordinate
    internal let category: GatherCategory
}

extension GatherConfigurationForAnnotation {
    internal func toAnnotation() -> Annotation {
        return Annotation(
            id: id,
            coordinate: coordinate.toCLLocationCoordinate2D(),
            gatherCategory: category
        )
    }
}
