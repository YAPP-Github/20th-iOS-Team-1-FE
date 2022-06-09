//
//  GatherListViewController.swift
//  App
//
//  Created by Hani on 2022/05/01.
//

import UIKit

import ReactorKit
import RxCocoa

final class GatherListViewController: BaseViewController {
    private lazy var segmentView: SegmentView = {
        let view = SegmentView()
        
        return view
    }()
    
    private lazy var contentTableView: GatherListTableView = {
        let tableView = GatherListTableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.separatorInsetReference = .fromAutomaticInsets
        tableView.separatorColor = .Togaether.line
        
        return tableView
    }()

    var disposeBag = DisposeBag()
    
    init(reactor: GatherListReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureLayout()
        configureUI()
    }
    
    private func addSubviews() {
        view.addSubview(segmentView)
        view.addSubview(contentTableView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            segmentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            segmentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            segmentView.heightAnchor.constraint(equalToConstant: 42),
            
            contentTableView.topAnchor.constraint(equalTo: segmentView.bottomAnchor),
            contentTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .Togaether.background
    }
    
    private func bindAction(with reactor: GatherListReactor) {
        
    }
    
    private func bindState(with reactor: GatherListReactor) {
        
    }
    
    func bind(reactor: GatherListReactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
}

extension GatherListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: GatherListCell.self, for: indexPath) as? GatherListCell else {
            return UITableViewCell()
        }
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutSubviews()

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 218
    }

}
