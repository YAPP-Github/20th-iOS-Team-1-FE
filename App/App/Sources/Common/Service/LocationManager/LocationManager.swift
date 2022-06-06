//
//  LocationManager.swift
//  App
//
//  Created by 유한준 on 2022/06/06.
//

import CoreLocation

final class LocationManager: LocationManageable {
    
    internal static var shared = LocationManager()
    private var locationManager: CLLocationManager?
    
    private init() {
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    internal func requestAuthorization() {
        locationManager?.requestWhenInUseAuthorization()
    }
    
    internal func startUpdateLocation() {
        locationManager?.startUpdatingLocation()
    }
    
    internal func currentLocation() -> CLLocation? {
        return locationManager?.location
    }
}
