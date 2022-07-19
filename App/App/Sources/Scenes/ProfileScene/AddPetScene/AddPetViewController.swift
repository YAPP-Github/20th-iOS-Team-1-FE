//
//  AddPetViewController.swift
//  App
//
//  Created by 김나희 on 6/30/22.
//

import UIKit

import ReactorKit
import RxCocoa

final class AddPetViewController: BaseViewController {
    var disposeBag = DisposeBag()
    
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    private lazy var addPetContentView = AddPetContentView()

    
    init(reactor: AddPetReactor) {
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
        contentView.addSubview(addPetContentView)
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
            
            addPetContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            addPetContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            addPetContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            addPetContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: addPetContentView.bottomAnchor)
        ])
        
        let contentViewHeight = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
    }
    
    private func configureUI() {
        view.backgroundColor = .Togaether.background
    }
    
    private func bindAction(with reactor: AddPetReactor) {
        disposeBag.insert {
            addPetContentView.profileImageButton.rx.tap.flatMapLatest { [weak self] (_) in
                return UIImagePickerController.rx.createWithParent(parent: self) { picker in
                    picker.sourceType = .photoLibrary
                    picker.allowsEditing = true
                }
                .flatMap { $0.rx.didFinishPickingMediaWithInfo }
                .take(1)
                }
                .map { $0[.editedImage] as? UIImage }
                .map { $0?.pngData() }
                .map { Reactor.Action.profileImageDidPick($0) }
                .bind(to: reactor.action)
            
            addPetContentView.nameTextField.rx.text
                .orEmpty
                .distinctUntilChanged()
                .map { Reactor.Action.nameTextFieldDidEndEditing($0) }
                .bind(to: reactor.action)

//            addPetContentView.ageTextField.rx.text
//                .map { Reactor.Action.dateDidEndEditing($0) }
//                .bind(to: reactor.action)

            addPetContentView.smallPetButton.rx.throttleTap
                .map { Reactor.Action.smallPetButtonDidTap }
                .bind(to: reactor.action)
                
            addPetContentView.middlePetButton.rx.throttleTap
                .map { Reactor.Action.middlePetButtonDidTap }
                .bind(to: reactor.action)
                
            addPetContentView.largePetButton.rx.throttleTap
                .map { Reactor.Action.largePetButtonDidTap }
                .bind(to: reactor.action)
            
            addPetContentView.searchBreedBar.rx.tapGesture()
                .when(.recognized)
                .map { _ in Reactor.Action.searchBarDidTap }
                .bind(to: reactor.action)
            
            addPetContentView.manButton.rx.throttleTap
                .map { Reactor.Action.manButtonDidTap }
                .bind(to: reactor.action)
                
            addPetContentView.womanButton.rx.throttleTap
                .map { Reactor.Action.womanButtonDidTap }
                .bind(to: reactor.action)
            
            addPetContentView.sexlessButton.rx.throttleTap
                .map { Reactor.Action.sexlessButtonDidTap }
                .bind(to: reactor.action)
                
            addPetContentView.genderedButton.rx.throttleTap
                .map { Reactor.Action.genderedButtonDidTap }
                .bind(to: reactor.action)
            
            addPetContentView.activeButton.rx.throttleTap
                .map { Reactor.Action.activeButtonDidTap }
                .bind(to: reactor.action)
                
            addPetContentView.docileButton.rx.throttleTap
                .map { Reactor.Action.docileButtonDidTap }
                .bind(to: reactor.action)
            
            addPetContentView.sociableButton.rx.throttleTap
                .map { Reactor.Action.sociableButtonDidTap }
                .bind(to: reactor.action)
                
            addPetContentView.independentButton.rx.throttleTap
                .map { Reactor.Action.independentButtonDidTap }
                .bind(to: reactor.action)
            
            addPetContentView.adaptableButton.rx.throttleTap
                .map { Reactor.Action.adaptableButtonDidTap }
                .bind(to: reactor.action)
                
            addPetContentView.inadaptableButton.rx.throttleTap
                .map { Reactor.Action.inadaptableButtonDidTap }
                .bind(to: reactor.action)
        }
    }
    
    private func bindState(with reactor: AddPetReactor) {
        disposeBag.insert {
            reactor.state
                .map { $0.petInfo.imageFile }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: nil)
                .drive(with: self,
                   onNext: { this, imageData in
                    guard let imageData = imageData else {
                        return
                    }
                    
                    this.addPetContentView.profileImageButton.setImage(UIImage(data: imageData), for: .normal)
                })
            
            reactor.state
                .map { $0.isSmallSelected }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(addPetContentView.smallPetButton.rx.isSelected)
        
            reactor.state
                .map { $0.isMiddleSelected }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(addPetContentView.middlePetButton.rx.isSelected)
            
            reactor.state
                .map { $0.isLargeSelected }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(addPetContentView.largePetButton.rx.isSelected)
            
            reactor.state
                .map { $0.isManSelected }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(addPetContentView.manButton.rx.isSelected)
        
            reactor.state
                .map { $0.isWomanSelected }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(addPetContentView.womanButton.rx.isSelected)
            
            reactor.state
                .map { $0.isSexlessSelected }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(addPetContentView.sexlessButton.rx.isSelected)
            
            reactor.state
                .map { $0.isGenderedSelected }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(addPetContentView.genderedButton.rx.isSelected)
            
            reactor.state
                .map { $0.isActiveSelected }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(addPetContentView.activeButton.rx.isSelected)
            
            reactor.state
                .map { $0.isDocileSelected }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(addPetContentView.docileButton.rx.isSelected)
            
            reactor.state
                .map { $0.isSociableSelected }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(addPetContentView.sociableButton.rx.isSelected)
            
            reactor.state
                .map { $0.isIndependentSelected }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(addPetContentView.independentButton.rx.isSelected)
            
            reactor.state
                .map { $0.isAdaptableSelected }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(addPetContentView.adaptableButton.rx.isSelected)
            
            reactor.state
                .map { $0.isInadaptableSelected }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(addPetContentView.inadaptableButton.rx.isSelected)
            
            reactor.state
                .map { $0.petInfo }
                .subscribe(onNext: {
                    print($0)
                })
        }
        
    }
    
    func bind(reactor: AddPetReactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}
