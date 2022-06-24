//
//  IntroduceView.swift
//  App
//
//  Created by 김나희 on 6/25/22.
//

import UIKit

final class IntroduceView: UIView {

    private lazy var introLabel: UILabel = {
        let label = UILabel()
        label.text = "자기소개와 관심 카테고리를 추가해보세요!"
        label.textColor = .white
        label.font = .customFont(size: 14, style: .SemiBold)
        
        return label
    }()
    
    private lazy var indicator: UIButton = {
        let button = UIButton()
        button.setImage(.Togaether.rightArrow, for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    private lazy var divisionView: UIView = {
        let view = UIView()
        view.backgroundColor = .Togaether.introduceViewDivider
        
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configureLayout()
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(introLabel)
        addSubview(indicator)

    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            introLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            introLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            
            indicator.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            indicator.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            ])
    }
    
    private func configureUI() {
        backgroundColor = .Togaether.introduceViewBackground
    }
}
