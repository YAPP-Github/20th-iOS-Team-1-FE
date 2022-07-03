//
//  UIButton+Rx.swift
//  App
//
//  Created by Hani on 2022/05/28.
//

import UIKit

import RxCocoa
import RxSwift

extension Reactive where Base: UIButton {
    public var throttleTap: ControlEvent<Void> {
        return ControlEvent(events: tap.throttle(.milliseconds(500), latest: false, scheduler: MainScheduler.instance))
    }
}
