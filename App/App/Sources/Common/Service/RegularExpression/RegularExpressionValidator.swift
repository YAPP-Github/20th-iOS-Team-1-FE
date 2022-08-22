//
//  RegularExpressionValidator.swift
//  App
//
//  Created by Hani on 2022/06/02.
//

import Foundation

final class RegularExpressionValidator: RegularExpressionValidatable {
    func validate(nickname: String) -> Bool {
        let regularExpression = "^[ㄱ-ㅎ가-힣a-zA-Z0-9]{1,10}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regularExpression)
        
        return predicate.evaluate(with: nickname)
    }
}
