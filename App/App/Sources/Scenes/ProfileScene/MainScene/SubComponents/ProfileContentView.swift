//
//  ProfileContentView.swift
//  App
//
//  Created by 김나희 on 6/25/22.
//

import UIKit

final class ProfileContentView: UIView {
    let hasIntroduction = true // 임시

    private lazy var profileHeaderView: UITableViewHeaderFooterView = {
        let headerView = UITableViewHeaderFooterView()
        let backgroundView = UIView(frame: .zero)
        backgroundView.backgroundColor = .Togaether.mainGreen
        headerView.backgroundView = backgroundView
        headerView.frame = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 373))
        
        return headerView
    }()
    
    internal lazy var profileModifyButton: UIButton = {
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
    
    internal lazy var userNameLabel: UILabel = {
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
    
    internal lazy var addPuppyButton: UIButton = {
        let button = UIButton()
        button.setTitle("반려견 추가", for: .normal)
        button.setTitleColor(.Togaether.mainGreen, for: .normal)
        button.titleLabel?.font = .customFont(size: 14, style: .Regular)
        button.setImage(.Togaether.plus, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.Togaether.mainGreen.cgColor
        button.tintColor = UIColor.Togaether.mainGreen
        
        return button
    }()

    private lazy var dogListView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = .Togaether.background
        tableView.tableHeaderView = profileHeaderView
        tableView.registerCell(type: DogTableViewCell.self)
        
        return tableView
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
        profileHeaderView.addSubview(profileModifyButton)
        profileHeaderView.addSubview(profileImageView)
        profileHeaderView.addSubview(userNameLabel)
        profileHeaderView.addSubview(addressLabel)
        profileHeaderView.addSubview(divisionView)
        profileHeaderView.addSubview(ageLabel)
        profileHeaderView.addSubview(genderImageView)
        profileHeaderView.addSubview(initailIntroduceView)
        profileHeaderView.addSubview(introduceView)
        addSubview(dogListView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            profileModifyButton.topAnchor.constraint(equalTo: profileHeaderView.topAnchor, constant: 20),
            profileModifyButton.trailingAnchor.constraint(equalTo: profileHeaderView.trailingAnchor, constant: -19),
            profileModifyButton.widthAnchor.constraint(equalToConstant: 93),
            profileModifyButton.heightAnchor.constraint(equalToConstant: 26),

            profileImageView.topAnchor.constraint(equalTo: profileHeaderView.topAnchor, constant: 40),
            profileImageView.leadingAnchor.constraint(equalTo: profileHeaderView.leadingAnchor, constant: 20),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            
            userNameLabel.topAnchor.constraint(equalTo: profileModifyButton.bottomAnchor, constant: 26),
            userNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20),
            userNameLabel.trailingAnchor.constraint(equalTo: profileHeaderView.trailingAnchor, constant: -43),
            
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
            initailIntroduceView.leadingAnchor.constraint(equalTo: profileHeaderView.leadingAnchor, constant: 20),
            initailIntroduceView.trailingAnchor.constraint(equalTo: profileHeaderView.trailingAnchor, constant: -20),
            initailIntroduceView.heightAnchor.constraint(equalToConstant: 48),
            
            introduceView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            introduceView.leadingAnchor.constraint(equalTo: profileHeaderView.leadingAnchor, constant: 20),
            introduceView.trailingAnchor.constraint(equalTo: profileHeaderView.trailingAnchor, constant: -20),
            introduceView.heightAnchor.constraint(equalToConstant: 151),
            
            dogListView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            dogListView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            dogListView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            dogListView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureUI() {
        backgroundColor = .Togaether.background
    }
}

extension ProfileContentView: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: DogTableViewCell.self, for: indexPath) as? DogTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }

    func tableView(_ tableView: UITableView,
                   viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: dogListView.frame.width, height: 100))
        footerView.addSubview(addPuppyButton)
        NSLayoutConstraint.useAndActivateConstraints([
            addPuppyButton.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            addPuppyButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            addPuppyButton.widthAnchor.constraint(equalToConstant: 102),
            addPuppyButton.heightAnchor.constraint(equalToConstant: 33)
            ])
        footerView.backgroundColor = .Togaether.background

        return footerView
    }
    
    func tableView(_ tableView: UITableView,
                   heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
}
