//
//  SignUpAgreementViewController.swift
//  App
//
//  Created by Hani on 2022/05/24.
//

import UIKit

import ReactorKit
import RxGesture
import RxSwift

final class SignUpAgreementViewController: BaseViewController {
    typealias Reactor = SignUpAgreementReactor
    
    private let contentView = UIView()
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.keyboardDismissMode = .onDrag
        
        return scrollView
    }()
    
    private var guidanceLabel: UILabel = {
        let text = "서비스 이용을 위해\n약관 동의가 필요해요."
        let boldFont = UIFont.boldSystemFont(ofSize: 32)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.font, value: boldFont, range: (text as NSString).range(of: "약관 동의"))
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32)
        label.textColor = .Togaether.primaryLabel
        label.attributedText = attributedText
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private var agreementCheckBox = CheckBox()
    private var agreementLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .Togaether.primaryLabel
        label.text = "모든 약관에 동의합니다."
        
        return label
    }()
    
    private lazy var checkBoxContourView: UIView = {
        let contour = UIView()
        contour.backgroundColor = .Togaether.divider
        
        return contour
    }()
    
    private var termsOfServiceCheckBox = CheckBox()
    private var termsOfServiceLabel: UILabel = {
        let text = "서비스 이용약관에 동의합니다. [필수]"
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: (text as NSString).range(of: "서비스 이용약관"))
        
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .Togaether.primaryLabel
        label.attributedText = attributedText
        
        return label
    }()
    
    private var privacyPolicyCheckBox = CheckBox()
    private var privacyPolicyLabel: UILabel = {
        let text = "개인정보처리방침에 동의합니다. [필수]"
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: (text as NSString).range(of: "개인정보처리방침"))
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .Togaether.primaryLabel
        label.attributedText = attributedText
        
        return label
    }()

    private lazy var nextButtonContourView: UIView = {
        let contour = UIView()
        contour.backgroundColor = .Togaether.divider
        
        return contour
    }()

    private var nextButton: EnableButton = {
        let button = EnableButton()
        button.setTitle("다음", for: .normal)
        button.isEnabled = false
        
        return button
    }()
    
    var disposeBag = DisposeBag()

    init(reactor: Reactor) {
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
        
        contentView.addSubview(guidanceLabel)
        
        contentView.addSubview(agreementCheckBox)
        contentView.addSubview(agreementLabel)
        
        contentView.addSubview(checkBoxContourView)
        
        contentView.addSubview(termsOfServiceCheckBox)
        contentView.addSubview(termsOfServiceLabel)
        
        contentView.addSubview(privacyPolicyCheckBox)
        contentView.addSubview(privacyPolicyLabel)
        
        view.addSubview(nextButtonContourView)
        
        view.addSubview(nextButton)
    }
    
    private func configureLayout() {
        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
        NSLayoutConstraint.useAndActivateConstraints([
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -4),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            
            nextButtonContourView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            nextButtonContourView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            nextButtonContourView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -14),
            nextButtonContourView.heightAnchor.constraint(equalToConstant: 1),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: nextButtonContourView.topAnchor, constant: -14),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
       //     contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor),
            
            guidanceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 96),
            guidanceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            guidanceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            agreementCheckBox.topAnchor.constraint(equalTo: guidanceLabel.bottomAnchor, constant: 78),
            agreementCheckBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            agreementCheckBox.heightAnchor.constraint(equalToConstant: 36),
            agreementCheckBox.widthAnchor.constraint(equalToConstant: 36),
            agreementLabel.leadingAnchor.constraint(equalTo: agreementCheckBox.trailingAnchor, constant: 10),
            agreementLabel.centerYAnchor.constraint(equalTo: agreementCheckBox.centerYAnchor),
 
            checkBoxContourView.topAnchor.constraint(equalTo: agreementCheckBox.bottomAnchor, constant: 14),
            checkBoxContourView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            checkBoxContourView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            checkBoxContourView.heightAnchor.constraint(equalToConstant: 1),
            
            termsOfServiceCheckBox.topAnchor.constraint(equalTo: checkBoxContourView.bottomAnchor, constant: 14),
            termsOfServiceCheckBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            termsOfServiceCheckBox.heightAnchor.constraint(equalToConstant: 36),
            termsOfServiceCheckBox.widthAnchor.constraint(equalToConstant: 36),
            termsOfServiceLabel.leadingAnchor.constraint(equalTo: termsOfServiceCheckBox.trailingAnchor, constant: 10),
            termsOfServiceLabel.centerYAnchor.constraint(equalTo: termsOfServiceCheckBox.centerYAnchor),
            termsOfServiceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -46),
            
            privacyPolicyCheckBox.topAnchor.constraint(equalTo: termsOfServiceCheckBox.bottomAnchor, constant: 16),
            privacyPolicyCheckBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
            privacyPolicyCheckBox.heightAnchor.constraint(equalToConstant: 36),
            privacyPolicyCheckBox.widthAnchor.constraint(equalToConstant: 36),
            privacyPolicyLabel.leadingAnchor.constraint(equalTo: privacyPolicyCheckBox.trailingAnchor, constant: 10),
            privacyPolicyLabel.centerYAnchor.constraint(equalTo: privacyPolicyCheckBox.centerYAnchor)
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .Togaether.background
        scrollView.backgroundColor = .Togaether.background
    }
    
    private func bindAction(with reactor: Reactor) {
        disposeBag.insert {
            agreementCheckBox.rx.tap
                .map { Reactor.Action.agreementCheckBoxDidTap }
                .bind(to: reactor.action)
            
            termsOfServiceCheckBox.rx.tap
                .map { Reactor.Action.termsOfServiceCheckBoxDidTap }
                .bind(to: reactor.action)
            
            termsOfServiceLabel.rx.tapGesture()
                .when(.recognized)
                .map { _ in Reactor.Action.termsOfServiceLabelDidTap }
                .bind(to: reactor.action)
            
            privacyPolicyCheckBox.rx.tap
                .map { Reactor.Action.privacyPolicyCheckBoxDidTap }
                .bind(to: reactor.action)
            
            privacyPolicyLabel.rx.tapGesture()
                .when(.recognized)
                .map { _ in Reactor.Action.privacyPolicyLabelDidTap }
                .bind(to: reactor.action)
            
            nextButton.rx.throttleTap
                .map { Reactor.Action.nextButtonDidTap }
                .bind(to: reactor.action)
        }
    }
    
    private func bindState(with reactor: Reactor) {
        disposeBag.insert {
            reactor.state
                .map { $0.isAgreementChecked }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(agreementCheckBox.rx.isSelected)

            reactor.state
                .map { $0.isTermsOfServiceChecked }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(termsOfServiceCheckBox.rx.isSelected)

            reactor.state
                .map { $0.isPrivacyPolicyChecked }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(privacyPolicyCheckBox.rx.isSelected)

            reactor.state
                .map { $0.isAgreementChecked }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(nextButton.rx.isEnabled)
        }
    }
    
    func bind(reactor: Reactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
}
