//
//  EnableButton.swift
//  App
//
//  Created by Hani on 2022/06/03.
//

import UIKit

final class EnableButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setBackgroundColor(.Togaether.mainGreen, for: .normal)
        setBackgroundColor(.Togaether.secondaryButton, for: .disabled)
        
        isEnabled = false
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
