//
//  Array+Extension.swift
//  App
//
//  Created by Hani on 2022/04/23.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return self.indices ~= index ? self[index] : nil
    }
}
