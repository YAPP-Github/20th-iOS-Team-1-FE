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
        label.text = "우리 초코랑 같이 산책하실 분 구해요! 평행산책 같이 연습해요~"
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .customFont(size: 16, style: .Medium)
        
        return label
    }()
    
    
    private lazy var divisionView: UIView = {
        let view = UIView()
        view.backgroundColor = .Togaether.introduceViewDivider
        
        return view
    }()
    
    private lazy var category: UILabel = {
        let label = UILabel()
        label.text = "관심 카테고리"
        label.font = .customFont(size: 14, style: .Medium)
        label.textColor = .white
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
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
        addSubview(divisionView)
        addSubview(category)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            introLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            introLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            introLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            divisionView.topAnchor.constraint(equalTo: introLabel.bottomAnchor, constant: 10),
            divisionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            divisionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            divisionView.heightAnchor.constraint(equalToConstant: 1),

            
            category.topAnchor.constraint(equalTo: divisionView.bottomAnchor, constant: 10),
            category.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15)
            ])
    }
    
    private func configureUI() {
        backgroundColor = .Togaether.introduceViewBackground
    }
}
