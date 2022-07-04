//
//  ProfileContentView.swift
//  App
//
//  Created by 김나희 on 6/25/22.
//

import UIKit

import RxCocoa
import RxSwift

final class ProfileContentView: UIView {
    let disposeBag = DisposeBag()

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
        view.image = .Togaether.userDefaultProfile
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
        
        return view
    }()
    
    private lazy var introduceView: IntroduceView = {
        var view = IntroduceView()
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private lazy var profileFooterView: UIView = {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))

        return footerView
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
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = 132
        tableView.separatorStyle = .none
        tableView.backgroundColor = .Togaether.background
        tableView.allowsSelection = false
        tableView.tableHeaderView = profileHeaderView
        tableView.tableFooterView = profileFooterView
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
        profileFooterView.addSubview(addPuppyButton)
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
            
            dogListView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            dogListView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            dogListView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            dogListView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            addPuppyButton.centerXAnchor.constraint(equalTo: profileFooterView.centerXAnchor),
            addPuppyButton.centerYAnchor.constraint(equalTo: profileFooterView.centerYAnchor),
            addPuppyButton.widthAnchor.constraint(equalToConstant: 102),
            addPuppyButton.heightAnchor.constraint(equalToConstant: 33)
        ])
    }
    
    private func configureUI() {
        backgroundColor = .Togaether.background
    }
    
    internal func configureData(_ myPage: Bool, _ accountInfo: AccountInfo?, petInfo: [PetInfo]?) {
        guard let accountData = accountInfo,
              let petData = petInfo else {
            return
        }
        
        if !myPage {
            initailIntroduceView.isHidden = true
            introduceView.isHidden = false
            introduceView.configureData(accountData)
            addPuppyButton.isHidden = true
        } else {
            if accountData.Introduction != nil {
                initailIntroduceView.isHidden = true
                introduceView.isHidden = false
                introduceView.configureData(accountData)
            } else {
                initailIntroduceView.isHidden = false
                introduceView.isHidden = true
                profileHeaderView.frame = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 273))
            }
        }

        profileImageView.imageWithURL(accountData.profileImageURL ?? "")
        userNameLabel.text = accountData.nickName
        addressLabel.text = accountData.address
        ageLabel.text = accountData.age
        
        Observable.of(petData)
            .asDriver(onErrorJustReturn: [])
            .drive(dogListView.rx.items) { tableView, row, data in
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = tableView.dequeueReusableCell(withIdentifier: DogTableViewCell.identifier, for: indexPath) as? DogTableViewCell else {
                    return UITableViewCell()
                }
                cell.configureData(data)
                
                return cell
            }
            .disposed(by: disposeBag)
    }

}
