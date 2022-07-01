//
//  MapViewBottomSheetContentView.swift
//  App
//
//  Created by 유한준 on 2022/07/02.
//

import UIKit

class MapViewBottomSheetContentView: UIView {
    
    private lazy var categoryLabel: PaddingLabel = {
        let label = PaddingLabel(padding: UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0))
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.backgroundColor = .Togaether.mainGreen
        label.text = "카테고리"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        
        return label
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .Togaether.divider
        label.text = "00/00"
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textColor = .Togaether.primaryLabel
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "모임 제목"
        label.textColor = .Togaether.primaryLabel
        label.font = UIFont.boldSystemFont(ofSize: 16)

        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "모임 장소 주소"
        label.textColor = .Togaether.secondaryLabel
        label.font = UIFont.systemFont(ofSize: 12)

        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "12월 31일(월)"
        label.textColor = .Togaether.mainGreen
        label.font = UIFont.boldSystemFont(ofSize: 14)

        return label
    }()
    
    private lazy var divisionView: UIView = {
        let view = UIView()
        view.backgroundColor = .Togaether.line
        
        return view
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "오후 10시 30분 - 12시"
        label.textColor = .Togaether.primaryLabel
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    private lazy var hostProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 14
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var hostNickNameLabel: UILabel = {
        let label = UILabel()
        label.text = "호스트 닉네임"
        label.textColor = .Togaether.primaryLabel
        label.font = UIFont.systemFont(ofSize: 14)

        return label
    }()
    
    private lazy var tagStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.spacing = 4
        
        return stackView
    }()
    
    private lazy var dogTypeTagLabel: PaddingLabel = {
        let label = PaddingLabel(padding: UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0))
        label.backgroundColor = .white
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.Togaether.tagLine.cgColor
        label.font = .customFont(size: 12, style: .Regular)
        label.textColor = .Togaether.secondaryLabel
        label.textAlignment = .center
        label.text = "견종이름이어쩌구저쩌구열자가넘으면어쩌구저쩌구"
        label.lineBreakMode = .byTruncatingMiddle
        
        return label
    }()
    
    private lazy var dogSizeTagLabel: PaddingLabel = {
        let label = PaddingLabel(padding: UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0))
        label.backgroundColor = .white
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.Togaether.tagLine.cgColor
        label.font = .customFont(size: 12, style: .Regular)
        label.textColor = .Togaether.secondaryLabel
        label.textAlignment = .center
        label.text = "소,중,대형견"
        
        return label
    }()
    
    private lazy var sexTagLabel: PaddingLabel = {
        let label = PaddingLabel(padding: UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0))
        label.backgroundColor = .white
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.Togaether.tagLine.cgColor
        label.font = .customFont(size: 12, style: .Regular)
        label.textColor = .Togaether.secondaryLabel
        label.textAlignment = .center
        label.text = "여성 Only"
        
        return label
    }()

    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubviews()
        configureLayout()
        configureUI()
    }
    
    private func addSubviews() {
        addSubview(categoryLabel)
        addSubview(countLabel)
        addSubview(titleLabel)
        addSubview(addressLabel)
        addSubview(dateLabel)
        addSubview(divisionView)
        addSubview(timeLabel)
        addSubview(hostProfileImageView)
        addSubview(hostNickNameLabel)
        addSubview(tagStackView)
        tagStackView.addSubview(dogTypeTagLabel)
        tagStackView.addSubview(dogSizeTagLabel)
        tagStackView.addSubview(sexTagLabel)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            categoryLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 14.0),
            categoryLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            categoryLabel.heightAnchor.constraint(equalToConstant: 18.0),
            
            countLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 37.0),
            countLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            countLabel.widthAnchor.constraint(equalToConstant: 55.0),
            countLabel.heightAnchor.constraint(equalToConstant: 55.0),
            
            titleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 12.0),
            titleLabel.leadingAnchor.constraint(equalTo: categoryLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: countLabel.leadingAnchor, constant: -14.0),
            
            addressLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6.0),
            addressLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: countLabel.leadingAnchor, constant: -14.0),
            
            dateLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 12.0),
            dateLabel.leadingAnchor.constraint(equalTo: addressLabel.leadingAnchor),

            divisionView.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 8.0),
            divisionView.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            divisionView.widthAnchor.constraint(equalToConstant: 1.0),
            divisionView.heightAnchor.constraint(equalToConstant: 12.0),
            
            timeLabel.topAnchor.constraint(equalTo: dateLabel.topAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: divisionView.trailingAnchor, constant: 8.0),
            timeLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8.0),
            
            hostProfileImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16.0),
            hostProfileImageView.leadingAnchor.constraint(equalTo: addressLabel.leadingAnchor),
            hostProfileImageView.widthAnchor.constraint(equalToConstant: 28.0),
            hostProfileImageView.heightAnchor.constraint(equalToConstant: 28.0),
            
            hostNickNameLabel.leadingAnchor.constraint(equalTo: hostProfileImageView.trailingAnchor, constant: 8.0),
            hostNickNameLabel.centerYAnchor.constraint(equalTo: hostProfileImageView.centerYAnchor),
            
            tagStackView.topAnchor.constraint(equalTo: hostProfileImageView.bottomAnchor, constant: 16.0),
            tagStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            tagStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            tagStackView.heightAnchor.constraint(equalToConstant: 18),
            
            dogTypeTagLabel.heightAnchor.constraint(equalTo: tagStackView.heightAnchor),
            dogTypeTagLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 150),
            
            dogSizeTagLabel.leadingAnchor.constraint(equalTo: dogTypeTagLabel.trailingAnchor, constant: 4),
            dogSizeTagLabel.heightAnchor.constraint(equalTo:tagStackView.heightAnchor),
            dogSizeTagLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 50),
            
            sexTagLabel.leadingAnchor.constraint(equalTo: dogSizeTagLabel.trailingAnchor, constant: 4),
            sexTagLabel.heightAnchor.constraint(equalTo: tagStackView.heightAnchor),
            sexTagLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 50)
            ])
    }
    
    private func configureUI() {
        backgroundColor = .Togaether.background
    }
}
