//
//  LocationManageable.swift
//  App
//
//  Created by 유한준 on 2022/06/06.
//

import CoreLocation

protocol LocationManageable: AnyObject {
    func requestAuthorization()
    func startUpdateLocation()
    func currentLocation() -> CLLocation?
}
