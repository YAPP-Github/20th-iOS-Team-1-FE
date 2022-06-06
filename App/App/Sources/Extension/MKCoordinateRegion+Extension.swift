//
//  MKCoordinateRegion+Extension.swift
//  App
//
//  Created by 유한준 on 2022/06/06.
//

import MapKit

extension MKCoordinateRegion: Equatable {
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        return lhs.center == rhs.center && lhs.span == rhs.span
    }
}
