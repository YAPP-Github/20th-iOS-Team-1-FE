//
//  BorderButton.swift
//  App
//
//  Created by Hani on 2022/06/25.
//

import UIKit

final class BorderButton: UIButton {
    override var isSelected: Bool {
        didSet {
            switch isSelected {
            case true:
                layer.borderColor = UIColor.Togaether.mainGreen.cgColor
            case false:
                layer.borderColor = UIColor.Togaether.buttonDisabled.cgColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        layer.borderWidth = 1
        setTitleColor(UIColor.Togaether.mainGreen, for: .selected)
        setTitleColor(UIColor.Togaether.buttonDisabled, for: .normal)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
