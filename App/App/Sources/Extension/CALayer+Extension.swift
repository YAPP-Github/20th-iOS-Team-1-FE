//
//  CALayer+Extension.swift
//  App
//
//  Created by 유한준 on 2022/07/10.
//

import Foundation
import UIKit

extension CALayer {
    func addBorder(_ arrEdge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arrEdge {
            let border = CALayer()
            switch edge {
            case .top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
            case .bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
            case .left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.width)
            case .right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
            default:
                break
            }
            border.backgroundColor = color.cgColor
            self.addSublayer(border)
        }
    }
}
