//
//  TagCollectionViewCell.swift
//  App
//
//  Created by 김나희 on 6/9/22.
//

import UIKit

final class TagCollectionViewCell: UICollectionViewCell {
    private lazy var tagLabel: PaddingLabel = {
        let label = PaddingLabel(padding: UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0))
        label.backgroundColor = .white
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.Togaether.tagLine.cgColor
        label.font = .customFont(size: 12, style: .Regular)
        label.textColor = .Togaether.secondaryLabel
        label.textAlignment = .center
        
        return label
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
        contentView.addSubview(tagLabel)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            tagLabel.topAnchor.constraint(equalTo: topAnchor),
            tagLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            tagLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            tagLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func configureUI() {
        backgroundColor = .Togaether.background
    }
    
    internal func configureData(_ tag: String) {
        tagLabel.text = tag        
    }
}
