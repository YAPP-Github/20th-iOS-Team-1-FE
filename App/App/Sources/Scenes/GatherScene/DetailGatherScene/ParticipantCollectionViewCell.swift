//
//  ParticipantCollectionViewCell.swift
//  App
//
//  Created by Hani on 2022/07/23.
//

import UIKit

final class ParticipantCollectionViewCell: UICollectionViewCell {
    private let profileImageButton: CircularButton = {
        let button = CircularButton()
        button.setBackgroundImage(.Togaether.userDefaultProfile, for: .normal)
        button.backgroundColor = .Togaether.background
        
        return button
    }()
    
    private var nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(size: 12)
        label.textColor = .Togaether.primaryLabel
        label.lineBreakMode = .byTruncatingTail
        
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
        contentView.addSubview(profileImageButton)
        contentView.addSubview(nicknameLabel)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            profileImageButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            profileImageButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            profileImageButton.widthAnchor.constraint(equalToConstant: 56),
            profileImageButton.heightAnchor.constraint(equalToConstant: 56),
            
            nicknameLabel.centerXAnchor.constraint(equalTo: profileImageButton.centerXAnchor),
            nicknameLabel.topAnchor.constraint(equalTo: profileImageButton.bottomAnchor, constant: 8)
        ])
    }
    
    private func configureUI() {
        backgroundColor = .Togaether.background
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageButton.setImage(.Togaether.userDefaultProfile, for: .normal)
        nicknameLabel.text = ""
    }

    func configure(imageURLString: String, nickname: String) {
        profileImageButton.imageWithURL(imageURLString)
        nicknameLabel.text = nickname
    }
}
