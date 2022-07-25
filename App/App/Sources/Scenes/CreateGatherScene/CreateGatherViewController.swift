//
//  CreateGatherViewController.swift
//  App
//
//  Created by 김나희 on 7/25/22.
//

import UIKit

import ReactorKit
import RxCocoa

final class CreateGatherViewController: BaseViewController {
    var disposeBag = DisposeBag()
    
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    internal lazy var createGatherView = CreateGatherView()
    
    init(reactor: CreateGatherReactor) {
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
        contentView.addSubview(createGatherView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            createGatherView.topAnchor.constraint(equalTo: contentView.topAnchor),
            createGatherView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            createGatherView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            createGatherView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: createGatherView.bottomAnchor)
        ])
        
        let contentViewHeight = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
    }
    
    private func configureUI() {
        view.backgroundColor = .Togaether.background
    }
    
    private func bindAction(with reactor: CreateGatherReactor) {
        
    }
    
    private func bindState(with reactor: CreateGatherReactor) {
        disposeBag.insert {
            reactor.state
                .map { $0.address }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: nil)
                .drive(with: self,
                   onNext: { this, address in
                    this.createGatherView.addressTextField.text = address
                })
        }
        
    }
    
    func bind(reactor: CreateGatherReactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
}
