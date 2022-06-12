//
//  Reactive+Extension.swift
//  App
//
//  Created by 유한준 on 2022/06/10.
//

import Foundation
import MapKit

import RxCocoa
import RxSwift

extension Reactive where Base: MKMapView {
    var delegate: DelegateProxy<MKMapView, MKMapViewDelegate> {
        return RxMKMapViewDelegateProxy.proxy(for: self.base)
    }
    
    public var didChangeVisibleRegion: ControlEvent<Void> {
        let source = delegate
            .methodInvoked(#selector(MKMapViewDelegate.mapViewDidChangeVisibleRegion(_:)))
            .map { _ in }
        return ControlEvent(events: source)
    }
}
