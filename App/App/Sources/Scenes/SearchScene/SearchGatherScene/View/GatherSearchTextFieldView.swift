//
//  GatherSearchTextFieldView.swift
//  App
//
//  Created by 유한준 on 2022/07/10.
//

import UIKit

final class GatherSearchTextFieldView: UIView {
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "장소, 모임 이름으로 찾기"
        return textField
    }()
    
    private lazy var imageView: UIImageView  = {
        let imageView = UIImageView(image: UIImage.Togaether.magnifyingglass)
        imageView.backgroundColor = .Togaether.background
        imageView.tintColor = .Togaether.mainYellow
        
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubviews()
        configureLayout()
    }
    
    private func addSubviews() {
        addSubview(imageView)
        addSubview(textField)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            imageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 25),
            imageView.widthAnchor.constraint(equalToConstant: 25),
            
            textField.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            textField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            textField.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            textField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
