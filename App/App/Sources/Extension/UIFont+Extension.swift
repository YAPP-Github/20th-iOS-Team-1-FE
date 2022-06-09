//
//  UIFont+Extension.swift
//  App
//
//  Created by 김나희 on 6/9/22.
//

import UIKit

extension UIFont {
    enum FontStyle: String {
        case ExtraBold, Bold, SemiBold, Medium, Regular
    }
    
    static func customFont(size: CGFloat = 10, style: FontStyle = .Regular) -> UIFont {
        return UIFont(name: "Pretendard-\(style)", size: size)!
    }
}
