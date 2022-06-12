//
//  RxMKMapViewDelegateProxy.swift
//  App
//
//  Created by 유한준 on 2022/06/10.
//

import Foundation
import MapKit

import RxCocoa

class RxMKMapViewDelegateProxy: DelegateProxy<MKMapView, MKMapViewDelegate>, DelegateProxyType, MKMapViewDelegate {
    static func registerKnownImplementations() {
        self.register { (mapView) -> RxMKMapViewDelegateProxy in
            RxMKMapViewDelegateProxy(parentObject: mapView, delegateProxy: self)
        }
    }
    
    static func currentDelegate(for object: MKMapView) -> MKMapViewDelegate? {
        return object.delegate
    }
    
    static func setCurrentDelegate(_ delegate: MKMapViewDelegate?, to object: MKMapView) {
        object.delegate = delegate
    }
}
