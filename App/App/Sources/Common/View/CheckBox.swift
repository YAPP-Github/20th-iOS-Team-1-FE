//
//  CheckBox.swift
//  App
//
//  Created by Hani on 2022/05/28.
//

import UIKit

import ReactorKit
import RxCocoa

final class CheckBox: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        let image = UIImage.Togaether.checkMarkCircle
            .withTintColor(.Togaether.checkBoxDidDeselect)
            .withRenderingMode(.alwaysOriginal)
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 36))
        
        let selectedImage = UIImage.Togaether.checkMarkCircleFill
            .withTintColor(.Togaether.mainGreen)
            .withRenderingMode(.alwaysOriginal)
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 36))
                               
        setImage(image, for: .normal)
        setImage(selectedImage, for: .selected)
        isSelected = false
    }
}
