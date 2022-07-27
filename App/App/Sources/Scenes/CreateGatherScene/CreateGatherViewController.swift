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
        disposeBag.insert {
            createGatherView.addressTextField.rx.text
                .orEmpty
                .skip(1)
                .distinctUntilChanged()
                .map { Reactor.Action.addressTextFieldDidEndEditing($0) }
                .bind(to: reactor.action)
            
            createGatherView.categorySelectView.walkButton.rx.tapGesture()
                .when(.recognized)
                .map { _ in Reactor.Action.walkButtonDidTap }
                .bind(to: reactor.action)
            
            createGatherView.categorySelectView.playgroundButton.rx.tapGesture()
                .when(.recognized)
                .map { _ in Reactor.Action.playgroundButtonDidTap }
                .bind(to: reactor.action)
            
            createGatherView.categorySelectView.dogCafeButton.rx.tapGesture()
                .when(.recognized)
                .map { _ in Reactor.Action.dogCafeButtonDidTap }
                .bind(to: reactor.action)
            
            createGatherView.categorySelectView.dogRestaurantButton.rx.tapGesture()
                .when(.recognized)

                .map { _ in Reactor.Action.dogRestaurantButtonDidTap }
                .bind(to: reactor.action)
           
            createGatherView.categorySelectView.fairButton.rx.tapGesture()
                .when(.recognized)
                .map { _ in Reactor.Action.fairButtonDidTap }
                .bind(to: reactor.action)
            
            createGatherView.categorySelectView.etcButton.rx.tapGesture()
                .when(.recognized)
                .map { _ in Reactor.Action.etcButtonDidTap }
                .bind(to: reactor.action)
            
            createGatherView.titleTextField.rx.text
                .orEmpty
                .distinctUntilChanged()
                .map { Reactor.Action.titleTextFieldDidEndEditing($0) }
                .bind(to: reactor.action)
            
            createGatherView.contentTextView.rx.text
                .orEmpty
                .distinctUntilChanged()
                .map { Reactor.Action.contentTextViewDidEndEditing($0) }
                .bind(to: reactor.action)
            
            createGatherView.startDateTextField.rx.text
                .orEmpty
                .distinctUntilChanged()
                .map { Reactor.Action.startDateTextFieldDidEndEditing($0) }
                .bind(to: reactor.action)
            
            createGatherView.startTimeTextField.rx.text
                .orEmpty
                .distinctUntilChanged()
                .map { Reactor.Action.startTimeTextFieldDidEndEditing($0) }
                .bind(to: reactor.action)
                
            createGatherView.endDateTextField.rx.text
                .orEmpty
                .distinctUntilChanged()
                .map { Reactor.Action.endDateTextFieldDidEndEditing($0) }
                .bind(to: reactor.action)
            
            createGatherView.endTimeTextField.rx.text
                .orEmpty
                .distinctUntilChanged()
                .map { Reactor.Action.endTimeTextFieldDidEndEditing($0) }
                .bind(to: reactor.action)
            
            createGatherView.numberTextField.rx.text
                .orEmpty
                .distinctUntilChanged()
                .map { Reactor.Action.numberOfPeopleTextFieldDidEndEditing(Int($0) ?? 0) }
                .bind(to: reactor.action)
            
            createGatherView.allGenderButton.rx.throttleTap
                .map { Reactor.Action.allGenderButtonDidTap }
                .bind(to: reactor.action)
            
            createGatherView.manButton.rx.throttleTap
                .map { Reactor.Action.manButtonDidTap }
                .bind(to: reactor.action)
            
            createGatherView.womanButton.rx.throttleTap
                .map { Reactor.Action.womanButtonDidTap }
                .bind(to: reactor.action)
            
            createGatherView.smallPetButton.rx.throttleTap
                .map { Reactor.Action.smallPetButtonDidTap }
                .bind(to: reactor.action)
                
            createGatherView.middlePetButton.rx.throttleTap
                .map { Reactor.Action.middlePetButtonDidTap }
                .bind(to: reactor.action)
                
            createGatherView.largePetButton.rx.throttleTap
                .map { Reactor.Action.largePetButtonDidTap }
                .bind(to: reactor.action)
            
            createGatherView.searchBreedBar.rx.tapGesture()
                .when(.recognized)
                .map { _ in Reactor.Action.searchBarDidTap }
                .bind(to: reactor.action)
            
            createGatherView.addButton.rx.throttleTap
                .map { Reactor.Action.createButtonDidTap }
                .bind(to: reactor.action)
        }
        
    }
    
    private func bindState(with reactor: CreateGatherReactor) {
        disposeBag.insert {
            reactor.state
            .map { $0.clubInfo.meetingPlace }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: nil)
                .drive(with: self,
                   onNext: { this, address in
                    this.createGatherView.addressTextField.text = address
                })
            
            reactor.state
                .map { $0.isWalkButtonSelected }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(with: self,
                   onNext: { this, isSelected in
                    this.createGatherView.categorySelectView.walkButton.isSelected = isSelected
                })
            
            
            reactor.state
                .map { $0.isPlaygroundButtonSelected }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(with: self,
                   onNext: { this, isSelected in
                    this.createGatherView.categorySelectView.playgroundButton.isSelected = isSelected
                })
            
            reactor.state
                .map { $0.isDogCafeButtonSelected }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(with: self,
                   onNext: { this, isSelected in
                    this.createGatherView.categorySelectView.dogCafeButton.isSelected = isSelected
                })
            
            reactor.state
                .map { $0.isDogRestaurantButtonSelected }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(with: self,
                   onNext: { this, isSelected in
                    this.createGatherView.categorySelectView.dogRestaurantButton.isSelected = isSelected
                })
            
            reactor.state
                .map { $0.isFairButtonSelected }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(with: self,
                   onNext: { this, isSelected in
                    this.createGatherView.categorySelectView.fairButton.isSelected = isSelected
                })
            
            reactor.state
                .map { $0.isEtcButtonSelected }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(with: self,
                   onNext: { this, isSelected in
                    this.createGatherView.categorySelectView.etcButton.isSelected = isSelected
                })
            
            reactor.state
                .map { $0.isAllGenderSelected }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(createGatherView.allGenderButton.rx.isSelected)
            
            reactor.state
                .map { $0.isManSelected }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(createGatherView.manButton.rx.isSelected)
        
            reactor.state
                .map { $0.isWomanSelected }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(createGatherView.womanButton.rx.isSelected)
            
            reactor.state
                .map { $0.isSmallSelected }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(createGatherView.smallPetButton.rx.isSelected)
        
            reactor.state
                .map { $0.isMiddleSelected }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(createGatherView.middlePetButton.rx.isSelected)
            
            reactor.state
                .map { $0.isLargeSelected }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(createGatherView.largePetButton.rx.isSelected)
            
            reactor.state
                .map { $0.isCreateButtonEnabled }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(createGatherView.addButton.rx.isEnabled)
            
            reactor.state
                .map { $0.clubInfo }
                .subscribe(onNext: {
                    print($0)
                })
            
            reactor.state
                .map { $0.isWalkButtonSelected }
                .subscribe(onNext: {
                    print($0)
                })
        }
    }
    
    func bind(reactor: CreateGatherReactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
}

extension CreateGatherViewController: SendBreed {
    func sendData(data: [String]) {
        createGatherView.breedCollectionView.reactor = TagCollectionViewReactor(state: data)
        
        Observable.just(data)
            .map { Reactor.Action.updateBreeds($0)}
            .bind(to: self.reactor!.action)
            .disposed(by: disposeBag)
    }
}
