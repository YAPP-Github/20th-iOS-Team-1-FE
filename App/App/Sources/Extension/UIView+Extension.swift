//
//  UIView+Extension.swift
//  App
//
//  Created by 유한준 on 2022/06/04.
//

import UIKit

extension UIView {
    internal func makeCircle() {
        self.layer.cornerRadius = self.layer.bounds.width / 2
        self.clipsToBounds = true
        
        self.setNeedsDisplay()
    }
}
