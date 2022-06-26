//
//  ProfileViewController.swift
//  App
//
//  Created by Hani on 2022/05/01.
//

import UIKit

import ReactorKit
import RxCocoa

final class ProfileViewController: BaseViewController {
    var disposeBag = DisposeBag()
        
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    private lazy var profileContentView = ProfileContentView()
    
    init(reactor: ProfileReactor) {
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
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(profileContentView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            profileContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            profileContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            profileContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            profileContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
    private func configureUI() {
        view.backgroundColor = .Togaether.background
    }
    
    private func bindAction(with reactor: ProfileReactor) {
        
    }
    
    private func bindState(with reactor: ProfileReactor) {
        
    }
    
    func bind(reactor: ProfileReactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
}
