//
//  RegularExpressionValidatable.swift
//  App
//
//  Created by Hani on 2022/06/02.
//

import Foundation

protocol RegularExpressionValidatable: AnyObject {
    func validate(nickname: String) -> Bool
}
