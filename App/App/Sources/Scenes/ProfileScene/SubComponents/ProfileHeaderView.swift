//
//  ProfileHeaderView.swift
//  App
//
//  Created by 김나희 on 6/27/22.
//

import UIKit

final class ProfileHeaderView: UITableViewHeaderFooterView {
    let hasIntroduction = true

    private lazy var profileModifyButton: UIButton = {
        let button = UIButton()
        button.setTitle("프로필 수정", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .customFont(size: 12.0, style: .Medium)
        button.setImage(.Togaether.profileSetting, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -2, bottom: 0, right: 0)
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        
        return button
    }()
    
    private lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 60
        
        return view
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = .customFont(size: 20, style: .Bold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "서울시 마포구"
        label.font = .customFont(size: 14, style: .ExtraBold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var divisionView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    private lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.text = "20세"
        label.font = .customFont(size: 14, style: .ExtraBold)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var genderImageView: UIImageView = {
        let view = UIImageView()
        view.image = .Togaether.genderSignMan
        
        return view
    }()
    
    private lazy var initailIntroduceView: UIView = {
        var view = InitialIntroductionView()
        view.layer.cornerRadius = 10
        view.isHidden = hasIntroduction
        
        return view
    }()
    
    private lazy var introduceView: UIView = {
        var view = IntroduceView()
        view.layer.cornerRadius = 10
        view.isHidden = !hasIntroduction
        
        return view
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubviews()
        configureLayout()
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(profileModifyButton)
        addSubview(profileImageView)
        addSubview(userNameLabel)
        addSubview(addressLabel)
        addSubview(divisionView)
        addSubview(ageLabel)
        addSubview(genderImageView)
        addSubview(initailIntroduceView)
        addSubview(introduceView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            profileModifyButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            profileModifyButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -19),
            profileModifyButton.widthAnchor.constraint(equalToConstant: 93),
            profileModifyButton.heightAnchor.constraint(equalToConstant: 26),

            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            profileImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            
            userNameLabel.topAnchor.constraint(equalTo: profileModifyButton.bottomAnchor, constant: 26),
            userNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20),
            userNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -43),
            
            addressLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 7.5),
            addressLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            
            divisionView.leadingAnchor.constraint(equalTo: addressLabel.trailingAnchor, constant: 8),
            divisionView.centerYAnchor.constraint(equalTo: addressLabel.centerYAnchor),
            divisionView.widthAnchor.constraint(equalToConstant: 1),
            divisionView.heightAnchor.constraint(equalToConstant: 12),
            
            ageLabel.topAnchor.constraint(equalTo: addressLabel.topAnchor),
            ageLabel.leadingAnchor.constraint(equalTo: divisionView.trailingAnchor, constant: 8),
            
            genderImageView.leadingAnchor.constraint(equalTo: ageLabel.trailingAnchor, constant: 8),
            genderImageView.centerYAnchor.constraint(equalTo: addressLabel.centerYAnchor),
            genderImageView.widthAnchor.constraint(equalToConstant: 24),
            genderImageView.heightAnchor.constraint(equalToConstant: 24),
            
            initailIntroduceView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            initailIntroduceView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            initailIntroduceView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            initailIntroduceView.heightAnchor.constraint(equalToConstant: 48),
            
            introduceView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            introduceView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            introduceView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            introduceView.heightAnchor.constraint(equalToConstant: 151),
            ])
    }
    
    private func configureUI() {
        let backgroundView = UIView(frame: .zero)
        backgroundView.backgroundColor = .Togaether.mainGreen
        self.backgroundView = backgroundView
    }
    
    internal func systemLayoutSizeFitting() -> CGSize {
        if hasIntroduction {
            return CGSize(width: UIScreen.main.bounds.width, height: 373)
        } else {
            return CGSize(width: UIScreen.main.bounds.width, height: 248)
        }
    }

}
