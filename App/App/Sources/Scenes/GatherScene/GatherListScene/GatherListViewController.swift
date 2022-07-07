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
    
    private lazy var contentTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(GatherListCell.self, forCellReuseIdentifier: GatherListCell.identifier)
        tableView.backgroundColor = .Togaether.background
        tableView.rowHeight = 180
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
        disposeBag.insert {
            segmentView.segmentControl.rx.selectedSegmentIndex
                .map { index in
                    Reactor.Action.segmentIndex(index: index) }
                .bind(to: reactor.action)
            
            contentTableView.rx.modelSelected(Content.self)
                .map { model in
                    Reactor.Action.gatherListCellDidTap(clubID: model.clubID) }
                .bind(to: reactor.action)
        }
    }
    
    private func bindState(with reactor: GatherListReactor) {
        disposeBag.insert {
            reactor.state
                .map { $0.gatherListInfo.clubInfos?.content ?? [] }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: [])
                .drive(self.contentTableView.rx.items) { tableView, row, data in
                    let indexPath = IndexPath(row: row, section: 0)
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: GatherListCell.identifier, for: indexPath) as? GatherListCell else {
                        return UITableViewCell()
                    }
                    cell.configureData(data)
                    
                    return cell
                }
            
            reactor.state
                .map { $0.isReadyToProceedDetailGatherView }
                .filter { $0.0 == true }
                .observe(on: MainScheduler.instance)
                .subscribe(with: self,
                   onNext: { this, data in
                    let detailGatherReactor = DetailGatherReactor(clubID: data.1)
                    let detailGatherViewController = DetailGatherViewController(reactor: detailGatherReactor)
                    this.navigationController?.pushViewController(detailGatherViewController, animated: true)
                })
        }
    }
    
    func bind(reactor: GatherListReactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
}
