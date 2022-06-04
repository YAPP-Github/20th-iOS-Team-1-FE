//
//  ContourView.swift
//  App
//
//  Created by Hani on 2022/06/03.
//

import UIKit

final class ContourView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .Togaether.divider
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
