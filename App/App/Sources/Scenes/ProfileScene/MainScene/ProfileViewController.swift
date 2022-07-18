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
    var nickName = ""
    
    private lazy var settingBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage.Togaether.setting
        
        return button
    }()
    
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
    
    override func viewDidLoad(){
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
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            profileContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            profileContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            profileContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            profileContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: profileContentView.bottomAnchor)
        ])
        
        let contentViewHeight = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
    }
    
    private func configureUI() {
        view.backgroundColor = .Togaether.background
        navigationItem.title = "프로필"
        navigationItem.rightBarButtonItem = settingBarButton
        navigationController?.navigationBar.tintColor = .Togaether.primaryLabel
    }
    
    private func bindAction(with reactor: ProfileReactor) {
        disposeBag.insert {
            Observable.just(nickName)
                .map { nickName in
                    Reactor.Action.profileInfo(nickname: nickName) }
                .bind(to: reactor.action)

            settingBarButton.rx.tap
                .map { Reactor.Action.settingButtonDidTap }
                .bind(to: reactor.action)
            
            profileContentView.introduceView.rx.tapGesture()
                .when(.recognized)
                .map { _ in Reactor.Action.introductionEditButtonDidTap(text: self.profileContentView.introduceView.introduceLabel.text ?? "") }
                .bind(to: reactor.action)
            
            profileContentView.initailIntroduceView.rx.tapGesture()
                .when(.recognized)
                .map { _ in Reactor.Action.introductionRegisterButtonDidTap }
                .bind(to: reactor.action)

            profileContentView.addPuppyButton.rx.tap
                .map { Reactor.Action.petAddButtonDidTap }
                .bind(to: reactor.action)
        }
    }
    
    private func bindState(with reactor: ProfileReactor) {
        disposeBag.insert {
            reactor.state
                .map { $0.profileInfo }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: ProfileInfo())
                .drive(onNext: { data in
                    self.profileContentView.configureData(data.myPage, data.accountInfo, petInfo: data.petInfos)
                })
            reactor.state
                .map { $0.shouldPresentAlertSheet }
                .filter { $0 == true }
                .observe(on: MainScheduler.instance)
                .subscribe(with: self,
                   onNext: { this, isEnabled in
                    self.presentAlertSheet()
                })
        }
        
    }
    
    func bind(reactor: ProfileReactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
                           
    
    private func presentAlertSheet() {
        let alertController = UIAlertController(title: "내 메뉴", message: nil, preferredStyle: .actionSheet)

        let logoutAction = UIAlertAction(title: "로그아웃", style: .default, handler: nil)
        let withdrawalAction = UIAlertAction(title: "투개더 탈퇴", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alertController.addAction(logoutAction)
        alertController.addAction(withdrawalAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
