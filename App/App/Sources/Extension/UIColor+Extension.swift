//
//  UIColor+Extension.swift
//  App
//
//  Created by Hani on 2022/05/25.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: Double = 1.0) {
        assert(0 <= red && red <= 255)
        assert(0 <= green && green <= 255)
        assert(0 <= blue && blue <= 255)

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }

    convenience init(rgb: Int, alpha: Double = 1.0) {
        self.init(red: (rgb >> 16) & 0xFF, green: (rgb >> 8) & 0xFF, blue: rgb & 0xFF, alpha: alpha)
    }
}

extension UIColor {
    enum Togaether {
        static let primaryLabel    = UIColor(named: "primaryLabel")!
        static let secondaryLabel  = UIColor(named: "secondaryLabel")!
        
        static let primaryButton   = UIColor(named: "primaryButton")!
        static let secondaryButton = UIColor(named: "secondaryButton")!
        
        static let tabBarIcon      = UIColor(named: "tabBarIcon")!
        static let icon            = UIColor(named: "icon")
        static let mainGreen       = UIColor(named: "mainGreen")!
        static let mainYellow      = UIColor(named: "mainYellow")!
        static let mainCoral       = UIColor(named: "mainCoral")!
        static let subGreen        = UIColor(named: "subGreen")!
        
        static let divider         = UIColor(named: "divider")!
        
        static let background      = UIColor(named: "background")!
        
        static let line            = UIColor(named: "line")!
        static let tagLine         = UIColor(named: "tagLine")!
    }
}
