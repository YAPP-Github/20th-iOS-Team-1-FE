//
//  Coordinate.swift
//  App
//
//  Created by 유한준 on 2022/06/06.
//

import CoreLocation

struct Coordinate: Codable {
    var latitude: Double
    var longitude: Double
}

extension Coordinate {
    func toCLLocationCoordinate2D() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(
            latitude: self.latitude,
            longitude: self.longitude
        )
    }
}

extension Coordinate {
    internal static var seoulCityHall: Coordinate {
        return Coordinate(
            latitude: 37.566667,
            longitude: 126.978368
        )
    }
}
