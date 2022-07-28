//
//  UILabel+Extension.swift
//  App
//
//  Created by 유한준 on 2022/07/05.
//

import UIKit

extension UILabel {
    func bold(targetString: String) {
        let fontSize = self.font.pointSize
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let fullText = self.text ?? ""
        let range = (fullText as NSString).range(of: targetString)
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.font, value: font, range: range)
        self.attributedText = attributedString
    }
    
    func countIcon(countString: String) {
        let attributedString = NSMutableAttributedString(string: countString)
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = .Togaether.participantIcon
        attributedString.append(NSAttributedString(attachment: imageAttachment))
        self.attributedText = attributedString
    }
}
