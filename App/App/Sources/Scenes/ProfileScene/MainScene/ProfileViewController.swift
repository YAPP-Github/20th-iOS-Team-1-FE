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
    let nickName: String? = "yapp" // 임시
        
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
        disposeBag.insert {
            Observable.just(nickName)
                .map { nickName in
                    Reactor.Action.profileInfo(nickname: nickName) }
                .bind(to: reactor.action)
            
            profileContentView.profileModifyButton.rx.tap
                .map { Reactor.Action.profileEditButtonDidTap }
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
                .drive(onNext: {
                    print($0)
                })
            
            reactor.state
                .map { $0.isReadyToProceedEditProfile }
                .filter { $0 == true }
                .observe(on: MainScheduler.instance)
                .subscribe(with: self,
                   onNext: { this, isEnabled in
                    let editProfileReactor = EditProflieReactor()
                    let editProfileViewController = EditProfileViewController(reactor: editProfileReactor)
                    this.navigationController?.pushViewController(editProfileViewController, animated: true)
                })
            
            reactor.state
                .map { $0.isReadyToProceedAddPet }
                .filter { $0 == true }
                .observe(on: MainScheduler.instance)
                .subscribe(with: self,
                   onNext: { this, isEnabled in
                    let addPetReactor = AddPetReactor()
                    let addPetViewController = AddPetViewController(reactor: addPetReactor)
                    this.navigationController?.pushViewController(addPetViewController, animated: true)
                })
        }
        
    }
    
    func bind(reactor: ProfileReactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
}
