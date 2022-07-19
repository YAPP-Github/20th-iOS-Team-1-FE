//
//  SearchBreedViewController.swift
//  App
//
//  Created by 김나희 on 7/19/22.
//

import UIKit

import ReactorKit
import RxCocoa

final class SearchBreedViewController: BaseViewController {
    var disposeBag = DisposeBag()

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .default
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.searchTextField.font = UIFont.customFont(size: 18, style: .Regular)
        searchBar.placeholder = "견종을 입력해주세요."
        searchBar.setImage(UIImage.Togaether.breedSearchIcon, for: UISearchBar.Icon.search, state: .normal)

        return searchBar
    }()

    private lazy var selectionView: TagCollectionView = {
        let view = TagCollectionView(reactor: TagCollectionViewReactor(state: []), frame: .zero)

        return view
    }()

    private lazy var breedTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .Togaether.background
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .Togaether.line
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        tableView.allowsMultipleSelection = true
        tableView.keyboardDismissMode = .onDrag

        return tableView
    }()

    init(reactor: SearchBreedReactor) {
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
        view.addSubview(searchBar)
        view.addSubview(selectionView)
        view.addSubview(breedTableView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            
            selectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            selectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            selectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            selectionView.heightAnchor.constraint(equalToConstant: 30),
            
            breedTableView.topAnchor.constraint(equalTo: selectionView.bottomAnchor, constant: 16),
            breedTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            breedTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            breedTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .Togaether.background
        navigationItem.title = "견종 선택"
    }
    
    private func bindAction(with reactor: SearchBreedReactor) {
        disposeBag.insert {
            searchBar.rx.text.orEmpty
                .debounce(RxTimeInterval.microseconds(5), scheduler: MainScheduler.instance)
                .distinctUntilChanged()
                .map { Reactor.Action.searchBreedDidEndEditing($0) }
                .bind(to: reactor.action)
            
            breedTableView.rx.itemSelected
                .map { Reactor.Action.breedDidTap($0.row) }
                .bind(to: reactor.action)
        }
    }

    private func bindState(with reactor: SearchBreedReactor) {
        disposeBag.insert {
            reactor.state
                .map { $0.searchResult }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: [])
                .drive(breedTableView.rx.items) { tableView, row, data in
                    let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: IndexPath(row: row, section: 0))
                    cell.textLabel?.text = data
                    cell.selectionStyle = .none

                    return cell
                }
            
            reactor.state
                .map { $0.selectedBreeds }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: [])
                .drive(onNext: {
                    self.selectionView.reactor = TagCollectionViewReactor(state: $0)
                })
        }
    }

    func bind(reactor: SearchBreedReactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    

}
