//
//  NSLayoutConstraint+Extension.swift
//  App
//
//  Created by Hani on 2022/04/23.
//

import UIKit

extension NSLayoutConstraint {
    class func useAndActivateConstraints(constraints: [NSLayoutConstraint]) {
        for constraint in constraints {
            if let view = constraint.firstItem as? UIView {
                 view.translatesAutoresizingMaskIntoConstraints = false
            }
        }
        activate(constraints)
    }
}
