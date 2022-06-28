//
//  ProfileContentView.swift
//  App
//
//  Created by 김나희 on 6/25/22.
//

import UIKit

final class ProfileContentView: UIView {
    private lazy var profileHeaderView: UITableViewHeaderFooterView = {
        let headerView = ProfileHeaderView()
        headerView.frame = CGRect(origin: .zero, size: headerView.systemLayoutSizeFitting())
        
        return headerView
    }()
    
    
    private lazy var addPuppyButton: UIButton = {
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
        addSubview(dogListView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
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
