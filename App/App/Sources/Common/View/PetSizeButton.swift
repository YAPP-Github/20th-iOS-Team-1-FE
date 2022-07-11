//
//  PetSizeButton.swift
//  App
//
//  Created by 김나희 on 7/11/22.
//

import UIKit

final class PetSizeButton: UIButton {
    enum SizeType {
        case small
        case middle
        case large
    }
    
    override var isSelected: Bool {
        didSet {
            switch isSelected {
            case true:
                layer.borderColor = UIColor.Togaether.mainGreen.cgColor
                imageView?.image?.withTintColor(UIColor.Togaether.mainGreen)
                if #available(iOS 15.0, *) {
                    configuration?.baseForegroundColor = UIColor.Togaether.mainGreen
                }
            case false:
                layer.borderColor = UIColor.Togaether.secondaryButton.cgColor
                imageView?.image?.withTintColor(UIColor.Togaether.secondaryButton)
                if #available(iOS 15.0, *) {
                    configuration?.baseForegroundColor = UIColor.Togaether.secondaryButton
                }
            }
        }
    }
    
    init(sizeType: SizeType, frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        layer.borderWidth = 1
        titleLabel?.font = UIFont.customFont(size: 12, style: .SemiBold)
        
        if #available(iOS 15.0, *) {
            configureUI(sizeType: sizeType)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @available(iOS 15.0, *)
    func configureUI(sizeType: SizeType) {
        var config = UIButton.Configuration.plain()
        config.baseBackgroundColor = UIColor.Togaether.background
        
        switch sizeType {
        case .small:
            config.image = UIImage.Togaether.smallPetIcon!.withRenderingMode(.alwaysTemplate)
            config.imagePadding = 5
            config.title = "소형견"
            config.subtitle = "10kg 미만"
            var text = AttributedString.init("소형견")
            text.font = UIFont.customFont(size: 16, style: .SemiBold)
            config.attributedTitle = text
            config.imagePlacement = NSDirectionalRectEdge.top
            configuration = config

        case .middle:
            config.image = UIImage.Togaether.middlePetIcon!.withRenderingMode(.alwaysTemplate)
            config.imagePadding = 5
            config.title = "중형견"
            config.subtitle = "10kg ~ 25kg"
            var text = AttributedString.init("중형견")
            text.font = UIFont.customFont(size: 16, style: .SemiBold)
            config.attributedTitle = text
            config.imagePlacement = NSDirectionalRectEdge.top
            configuration = config
            
        case .large:
            config.image = UIImage.Togaether.largePetIcon!.withRenderingMode(.alwaysTemplate)
            config.imagePadding = 5
            config.title = "대형견"
            config.subtitle = "25kg 이상"
            var text = AttributedString.init("대형견")
            text.font = UIFont.customFont(size: 16, style: .SemiBold)
            config.attributedTitle = text
            config.imagePlacement = NSDirectionalRectEdge.top
            configuration = config
        }
    }

}
