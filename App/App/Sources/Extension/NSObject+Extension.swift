//
//  NSObject+Extension.swift
//  App
//
//  Created by 김나희 on 6/9/22.
//

import Foundation

extension NSObject {
    static var identifier: String {
        return String(describing: self)
    }
}
