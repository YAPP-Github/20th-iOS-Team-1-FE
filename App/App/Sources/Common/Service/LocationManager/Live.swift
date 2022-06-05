//
//  Live.swift
//  App
//
//  Created by 유한준 on 2022/06/06.
//

import CoreLocation
import Foundation

extension CLLocationManager {
    internal static var live: CLLocationManager {
        let locationManger = CLLocationManager()
        
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestWhenInUseAuthorization()
        
        return locationManger
    }
}
