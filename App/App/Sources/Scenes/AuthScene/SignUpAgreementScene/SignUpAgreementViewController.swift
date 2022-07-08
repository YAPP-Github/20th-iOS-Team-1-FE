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
    
    private let guidanceLabel: UILabel = {
        let text = "서비스 이용을 위해\n약관 동의가 필요해요."
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.font, value: UIFont.customFont(size: 32, style: .Bold), range: (text as NSString).range(of: "약관 동의"))
        
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.attributedText = attributedText
        label.font = .customFont(size: 32)
        label.numberOfLines = 2
        label.textColor = .Togaether.primaryLabel
        
        return label
    }()
    
    private let agreementStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        
        return stackView
    }()
    private let agreementCheckBox = CheckBox()
    private let agreementLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = .customFont(size: 16)
        label.text = "모든 약관에 동의합니다."
        label.lineBreakMode = .byWordWrapping
        label.textColor = .Togaether.primaryLabel
        
        return label
    }()
    
    private let checkBoxDivider = Divider()
    
    private let termsOfServiceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        
        return stackView
    }()
    private let termsOfServiceCheckBox = CheckBox()
    private let termsOfServiceLabel: UILabel = {
        let text = "서비스 이용약관에 동의합니다. [필수]"
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: (text as NSString).range(of: "서비스 이용약관"))
        
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.attributedText = attributedText
        label.font = .customFont(size: 16)
        label.lineBreakMode = .byWordWrapping
        label.textColor = .Togaether.primaryLabel
        
        return label
    }()
    
    private let privacyPolicyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        
        return stackView
    }()
    private let privacyPolicyCheckBox = CheckBox()
    private let privacyPolicyLabel: UILabel = {
        let text = "개인정보처리방침에 동의합니다. [필수]"
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: (text as NSString).range(of: "개인정보처리방침"))
        
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.attributedText = attributedText
        label.font = .customFont(size: 16)
        label.lineBreakMode = .byWordWrapping
        label.textColor = .Togaether.primaryLabel
        
        return label
    }()

    private let nextButtonDivider = Divider()
    private let nextButton: EnableButton = {
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let contentRect: CGRect = contentView.subviews.reduce(into: .zero) { rect, view in
            rect = rect.union(view.frame)
        }
        scrollView.contentSize = contentRect.size
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(guidanceLabel)
        contentView.addSubview(agreementStackView)
        agreementStackView.addArrangedSubview(agreementCheckBox)
        agreementStackView.addArrangedSubview(agreementLabel)
        
        contentView.addSubview(checkBoxDivider)
        
        contentView.addSubview(termsOfServiceStackView)
        termsOfServiceStackView.addArrangedSubview(termsOfServiceCheckBox)
        termsOfServiceStackView.addArrangedSubview(termsOfServiceLabel)
        contentView.addSubview(privacyPolicyStackView)
        privacyPolicyStackView.addArrangedSubview(privacyPolicyCheckBox)
        privacyPolicyStackView.addArrangedSubview(privacyPolicyLabel)
        
        view.addSubview(nextButtonDivider)
        view.addSubview(nextButton)
    }
    
    private func configureLayout() {
        let viewHeight = view.frame.height
        NSLayoutConstraint.useAndActivateConstraints([
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -4),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            
            nextButtonDivider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            nextButtonDivider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            nextButtonDivider.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -4),
            nextButtonDivider.heightAnchor.constraint(equalToConstant: 1),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: nextButtonDivider.topAnchor, constant: -4),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor),
            
            guidanceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: viewHeight * 0.1),
            guidanceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            guidanceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            agreementStackView.topAnchor.constraint(equalTo: guidanceLabel.bottomAnchor, constant: viewHeight * 0.1),
            agreementStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            agreementStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            agreementCheckBox.heightAnchor.constraint(equalToConstant: 36),
            agreementCheckBox.widthAnchor.constraint(equalToConstant: 36),
 
            checkBoxDivider.topAnchor.constraint(equalTo: agreementCheckBox.bottomAnchor, constant: 14),
            checkBoxDivider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            checkBoxDivider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            checkBoxDivider.heightAnchor.constraint(equalToConstant: 1),
            
            termsOfServiceStackView.topAnchor.constraint(equalTo: checkBoxDivider.bottomAnchor, constant: 14),
            termsOfServiceStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            termsOfServiceStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            termsOfServiceCheckBox.heightAnchor.constraint(equalToConstant: 36),
            termsOfServiceCheckBox.widthAnchor.constraint(equalToConstant: 36),
            
            privacyPolicyStackView.topAnchor.constraint(equalTo: termsOfServiceStackView.bottomAnchor, constant: 16),
            privacyPolicyStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            privacyPolicyStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            privacyPolicyCheckBox.heightAnchor.constraint(equalToConstant: 36),
            privacyPolicyCheckBox.widthAnchor.constraint(equalToConstant: 36),
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .Togaether.background
        contentView.backgroundColor = .Togaether.background
        
        navigationController?.navigationBar.isTranslucent = true

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
