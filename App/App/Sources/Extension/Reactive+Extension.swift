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

extension Reactive where Base: UIViewController {
    public enum ViewControllerViewState: Equatable {
        case viewWillAppear
        case viewDidAppear
        case viewWillDisappear
        case viewDidDisappear
        case viewDidLoad
        case viewDidLayoutSubviews
    }
    
    public var viewDidLoad: Observable<Void> {
        return methodInvoked(#selector(UIViewController.viewDidLoad))
            .map { _ in return }
    }
    
    public var viewDidLayoutSubviews: Observable<Void> {
        return methodInvoked(#selector(UIViewController.viewDidLayoutSubviews))
            .map { _ in return }
    }
    
    public var viewWillAppear: Observable<Bool> {
        return methodInvoked(#selector(UIViewController.viewWillAppear))
            .map { $0.first as? Bool ?? false }
    }
    
    public var viewDidAppear: Observable<Bool> {
        return methodInvoked(#selector(UIViewController.viewDidAppear))
            .map { $0.first as? Bool ?? false }
    }
    
    public var viewWillDisappear: Observable<Bool> {
        return methodInvoked(#selector(UIViewController.viewWillDisappear))
            .map { $0.first as? Bool ?? false }
    }
    
    public var viewDidDisappear: Observable<Bool> {
        return methodInvoked(#selector(UIViewController.viewDidDisappear))
            .map { $0.first as? Bool ?? false }
    }
    
    public var viewState: Observable<ViewControllerViewState> {
        return Observable.of(
            viewDidLoad.map { _ in
                return ViewControllerViewState.viewDidLoad
            },
            viewDidLayoutSubviews.map { _ in
                return ViewControllerViewState.viewDidLayoutSubviews
            },
            viewWillAppear.map { _ in
                return ViewControllerViewState.viewWillAppear
            },
            viewDidAppear.map { _ in
                return ViewControllerViewState.viewDidAppear
            },
            viewWillDisappear.map { _ in
                return ViewControllerViewState.viewWillDisappear
            },
            viewDidDisappear.map { _ in
                return ViewControllerViewState.viewDidDisappear
            }
        )
        .merge()
    }
}
