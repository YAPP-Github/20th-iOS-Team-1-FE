//
//  LocationManager.swift
//  App
//
//  Created by 유한준 on 2022/06/06.
//

import CoreLocation

final class LocationManager: NSObject, LocationManageable {
    
    internal static var shared = LocationManager()
    private var locationManager: CLLocationManager?
    
    override private init() {
        super.init()
        
        locationManager = CLLocationManager()
        
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.delegate = self
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

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        switch manager.authorizationStatus {
//        case .authorizedWhenInUse, .authorizedAlways:
//        default: break
//        }
    }
}
