//
//  CLLocationCoordinate2D+Extension.swift
//  App
//
//  Created by 유한준 on 2022/06/06.
//

import CoreLocation

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.longitude == rhs.longitude && lhs.latitude == rhs.latitude
    }
    
    func toCoordinate() -> Coordinate {
        return Coordinate(
            latitude: self.latitude,
            longitude: self.longitude
        )
    }
}
