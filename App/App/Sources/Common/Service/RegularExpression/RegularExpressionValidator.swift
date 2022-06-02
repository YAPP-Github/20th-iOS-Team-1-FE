//
//  RegularExpressionValidator.swift
//  App
//
//  Created by Hani on 2022/06/02.
//

import Foundation

final class RegularExpressionValidator: RegularExpressionValidatable {
    func validate(nickname: String) -> Bool {
        let regularExpression = "[A-Za-z가-힇]{4,10}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regularExpression)
        
        return predicate.evaluate(with: nickname)
    }
}
