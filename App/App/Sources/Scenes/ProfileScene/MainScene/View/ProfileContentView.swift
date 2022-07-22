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

    internal lazy var profileHeaderView: UITableViewHeaderFooterView = {
        let headerView = UITableViewHeaderFooterView()
        let backgroundView = UIView()
        backgroundView.backgroundColor = .Togaether.mainGreen
        headerView.backgroundView = backgroundView
        headerView.frame = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 373))
        
        return headerView
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
    
    internal lazy var initailIntroduceView: UIView = {
        var view = InitialIntroductionView()
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    internal lazy var introduceView: UIView = {
        var view = UIView()
        view.backgroundColor = .Togaether.subGreen
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    internal lazy var introduceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .customFont(size: 16, style: .Medium)
        
        return label
    }()
    
    internal lazy var emptyPetView: EmptyNoticeView = {
        let view = EmptyNoticeView(frame: .zero, type: .pet)

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
    
    private lazy var profileFooterView: UIView = {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 300))

        return footerView
    }()

    internal lazy var petListView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.rowHeight = 132
        tableView.separatorStyle = .none
        tableView.backgroundColor = .Togaether.background
        tableView.allowsSelection = false
        tableView.tableHeaderView = profileHeaderView
        tableView.tableFooterView = profileFooterView
        tableView.register(PetTableViewCell.self, forCellReuseIdentifier: PetTableViewCell.identifier)
        
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
        profileHeaderView.addSubview(profileImageView)
        profileHeaderView.addSubview(userNameLabel)
        profileHeaderView.addSubview(addressLabel)
        profileHeaderView.addSubview(divisionView)
        profileHeaderView.addSubview(ageLabel)
        profileHeaderView.addSubview(genderImageView)
        profileHeaderView.addSubview(initailIntroduceView)
        profileHeaderView.addSubview(introduceView)
        introduceView.addSubview(introduceLabel)
        addSubview(petListView)
        addSubview(emptyPetView)
        profileFooterView.addSubview(addPuppyButton)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            profileImageView.topAnchor.constraint(equalTo: profileHeaderView.topAnchor, constant: 40),
            profileImageView.leadingAnchor.constraint(equalTo: profileHeaderView.leadingAnchor, constant: 20),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            
            userNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20),
            userNameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            
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
            initailIntroduceView.bottomAnchor.constraint(equalTo: profileHeaderView.bottomAnchor, constant: -30),
            
            introduceView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            introduceView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            introduceView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            introduceView.bottomAnchor.constraint(equalTo: profileHeaderView.bottomAnchor, constant: -30),
            
            introduceLabel.topAnchor.constraint(equalTo: introduceView.topAnchor, constant: 10),
            introduceLabel.leadingAnchor.constraint(equalTo: introduceView.leadingAnchor, constant: 10),
            introduceLabel.trailingAnchor.constraint(equalTo: introduceView.trailingAnchor, constant: -10),
            introduceLabel.bottomAnchor.constraint(equalTo: introduceView.bottomAnchor, constant: -10),
            
            petListView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            petListView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            petListView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            petListView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            emptyPetView.topAnchor.constraint(equalTo: profileHeaderView.bottomAnchor, constant: 50),
            emptyPetView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            emptyPetView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            emptyPetView.heightAnchor.constraint(equalToConstant: 250),
            
            addPuppyButton.centerXAnchor.constraint(equalTo: profileFooterView.centerXAnchor),
            addPuppyButton.bottomAnchor.constraint(equalTo: profileFooterView.bottomAnchor),
            addPuppyButton.widthAnchor.constraint(equalToConstant: 102),
            addPuppyButton.heightAnchor.constraint(equalToConstant: 33)
        ])
    }
    
    private func configureUI() {
        backgroundColor = .Togaether.background
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let headerView = petListView.tableHeaderView else {
            return
        }
        let headerSize = headerView.systemLayoutSizeFitting(CGSize(width: bounds.size.width, height: UIView.layoutFittingCompressedSize.height))
        headerView.frame.size.height = headerSize.height + 50.0
        petListView.tableHeaderView = headerView
    }
    
    internal func configureData(_ myPage: Bool, _ accountInfo: AccountInfo?, petInfo: [PetInfo]?) {
        guard let accountData = accountInfo,
              let petData = petInfo else {
            return
        }
        
        if !myPage {
            initailIntroduceView.removeFromSuperview()
            introduceView.isHidden = false
            introduceLabel.text = accountData.Introduction
            addPuppyButton.removeFromSuperview()
        } else {
            if accountData.Introduction != nil {
                initailIntroduceView.removeFromSuperview()
                introduceView.isHidden = false
                introduceLabel.text = accountData.Introduction
            } else {
                initailIntroduceView.isHidden = false
                introduceView.removeFromSuperview()
            }
        }

        profileImageView.imageWithURL(accountData.profileImageURL ?? "")
        userNameLabel.text = accountData.nickName
        addressLabel.text = accountData.address
        ageLabel.text = accountData.age
                  
        if !petData.isEmpty || !myPage {
            emptyPetView.removeFromSuperview()
        }
        
        Observable.of(petData)
            .asDriver(onErrorJustReturn: [])
            .drive(petListView.rx.items) { tableView, row, data in
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PetTableViewCell.identifier, for: indexPath) as? PetTableViewCell else {
                    return UITableViewCell()
                }
                cell.configureData(data)
            
                return cell
            }
            .disposed(by: disposeBag)
    }

}
