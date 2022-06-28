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

    private lazy var dogListView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
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
        return 2
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
}
