//
//  GuideView.swift
//  App
//
//  Created by Hani on 2022/07/01.
//

import UIKit

final class GuideView: UIView {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        stackView.alignment = .leading
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.textColor = .Togaether.primaryLabel
        
        return label
    }()
    
    private lazy var guideLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .Togaether.secondaryLabel
        label.numberOfLines = 10
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    init(title: String, guide: String) {
        super.init(frame: .zero)
        addSubviews()
        configureLabel(title: title, guide: guide)
        configureLayout()
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.sizeToFit()
        guideLabel.sizeToFit()
    }
    
    private func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(guideLabel)
    }

    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    private func configureUI() {
        backgroundColor = .Togaether.divider
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }
    
    private func configureLabel(title: String, guide: String) {
        titleLabel.text = title
        guideLabel.text = guide
    }
}
