//
//  PaddingLabel.swift
//  App
//
//  Created by 김나희 on 6/9/22.
//

import UIKit

final class PaddingLabel: UILabel {
    private var topPadding: CGFloat = 0.0
    private var leadingPadding: CGFloat = 0.0
    private var bottomPadding: CGFloat = 0.0
    private var trailingPadding: CGFloat = 0.0
    
    convenience init(padding: UIEdgeInsets) {
        self.init()
        topPadding = padding.top
        leadingPadding = padding.left
        bottomPadding = padding.bottom
        trailingPadding = padding.right
    }
    
    override func drawText(in rect: CGRect) {
        let padding = UIEdgeInsets.init(top: topPadding, left: leadingPadding, bottom: bottomPadding, right: trailingPadding)
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        if self.text == nil {
            return CGSize(width: 0, height: 0)
        }
        
        var contentSize = super.intrinsicContentSize
        contentSize.width += leadingPadding + trailingPadding
        contentSize.height += topPadding + bottomPadding
        
        return contentSize
    }
    
    func tagLabel(_ text: String?) -> UILabel{
        let label = PaddingLabel(padding: UIEdgeInsets(top: 2.0, left: 8.0, bottom: 2.0, right: 8.0))
        label.text = text ?? ""
        label.backgroundColor = .white
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.Togaether.tagLine.cgColor
        label.font = .customFont(size: 11, style: .Regular)
        label.textColor = .Togaether.secondaryLabel
        label.textAlignment = .center
        
        return label
    }
}
