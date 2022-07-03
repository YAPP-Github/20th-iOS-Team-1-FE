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
    
    enum CodingKeys: String, CodingKey {
        case id = "clubId"
        case category
        case clubLatitude
        case clubLongitude
    }
    
    init(id: Int, coordinate: Coordinate, category: GatherCategory) {
        self.id = id
        self.coordinate = coordinate
        self.category = category
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        
        let latitude = try container.decode(Double.self, forKey: .clubLatitude)
        let longitude = try container.decode(Double.self, forKey: .clubLongitude)
        self.coordinate = Coordinate(latitude: latitude, longitude: longitude)
        
        self.category = try container.decode(GatherCategory.self, forKey: .category)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(coordinate.latitude, forKey: .clubLatitude)
        try container.encode(coordinate.longitude, forKey: .clubLongitude)
        try container.encode(category, forKey: .category)
    }
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
