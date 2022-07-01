//
//  MKMapView+Extension.swift
//  App
//
//  Created by 유한준 on 2022/07/01.
//

import CoreLocation
import MapKit

extension MKMapView {
    func topLeftCoordinate() -> CLLocationCoordinate2D {
        return convert(.zero, toCoordinateFrom: self)
    }

    func bottomRightCoordinate() -> CLLocationCoordinate2D {
        return convert(CGPoint(x: frame.width, y: frame.height), toCoordinateFrom: self)
    }
}
