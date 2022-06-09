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
        var contentSize = super.intrinsicContentSize
        contentSize.width += leadingPadding + trailingPadding
        contentSize.height += topPadding + bottomPadding
        
        return contentSize
    }
}
