//
//  String+Extension.swift
//  App
//
//  Created by Hani on 2022/07/02.
//

import Foundation

extension String {
    func makePrefixBearer() -> String {
        return "Bearer " + self
    }
}
