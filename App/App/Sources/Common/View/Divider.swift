//
//  Divider.swift
//  App
//
//  Created by Hani on 2022/07/04.
//

import UIKit

final class Divider: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .Togaether.divider
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
