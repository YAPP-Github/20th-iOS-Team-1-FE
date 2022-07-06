//
//  SignUpInfomationViewController.swift
//  App
//
//  Created by Hani on 2022/06/03.
//

import UIKit

import ReactorKit
import RxKeyboard

final class SignUpInfomationViewController: BaseViewController {
    private let contentView = UIView()
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.keyboardDismissMode = .onDrag
        
        return scrollView
    }()
    
    private var guidanceLabel: UILabel = {
        let text = "견주님의 나이와\n성별을 알려주세요."
        let boldFont = UIFont.boldSystemFont(ofSize: 32)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.font, value: boldFont, range: (text as NSString).range(of: "견주님의 나이"))
        attributedText.addAttribute(.font, value: boldFont, range: (text as NSString).range(of: "성별"))
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32)
        label.textColor = .Togaether.primaryLabel
        label.attributedText = attributedText
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private var ageLabel: UILabel = {
        let label = UILabel()
        label.text = "나이 입력"
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    private var ageContourView = ContourView()
    
    private var ageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "입력해주세요."
        textField.keyboardType = .numberPad
        
        return textField
    }()
    
    private var sexLabel: UILabel = {
        let label = UILabel()
        label.text = "성별 선택"
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    private var manButton: BorderButton = {
        let button = BorderButton()
        button.setTitle("남자입니다!", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        
        return button
    }()
    
    private var womanButton:BorderButton = {
        let button = BorderButton()
        button.setTitle("여자입니다!", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        
        return button
    }()
    
    private lazy var sexStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        
        return stackView
    }()
    
    private lazy var nextButtonContourView = ContourView()

    private var nextButton: EnableButton = {
        let button = EnableButton()
        button.setTitle("다음", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        
        return button
    }()
    
    var disposeBag = DisposeBag()
    
    init(reactor: SignUpInfomationReactor) {
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
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        view.endEditing(true)
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(guidanceLabel)
        
        contentView.addSubview(ageLabel)
        contentView.addSubview(ageTextField)
        contentView.addSubview(ageContourView)
        
        contentView.addSubview(sexLabel)
        contentView.addSubview(sexStackView)
        sexStackView.addArrangedSubview(manButton)
        sexStackView.addArrangedSubview(womanButton)
        
        view.addSubview(nextButtonContourView)
        view.addSubview(nextButton)
    }
    
    private func configureLayout() {
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
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor),
            
            guidanceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 96),
            guidanceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            guidanceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            ageLabel.topAnchor.constraint(equalTo: guidanceLabel.bottomAnchor, constant: 72),
            ageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            ageTextField.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 20),
            ageTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            ageContourView.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 15),
            ageContourView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            ageContourView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            sexLabel.topAnchor.constraint(equalTo: ageContourView.bottomAnchor, constant: 44),
            sexLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            sexStackView.topAnchor.constraint(equalTo: sexLabel.bottomAnchor, constant: 20),
            sexStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            sexStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            sexStackView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .Togaether.background
        scrollView.backgroundColor = .Togaether.background
    }
    
    private func bindAction(with reactor: SignUpInfomationReactor) {
        disposeBag.insert {
            ageTextField.rx.value
                .orEmpty
                .distinctUntilChanged()
                .map { Reactor.Action.ageTextFieldDidEndEditing($0) }
                .bind(to: reactor.action)
            
            manButton.rx.throttleTap
                .map { Reactor.Action.manButtonDidTap }
                .bind(to: reactor.action)
            
            womanButton.rx.throttleTap
                .map { Reactor.Action.womanButtonDidTap }
                .bind(to: reactor.action)
            
            nextButton.rx.throttleTap
                .map { Reactor.Action.nextButtonDidTap }
                .bind(to: reactor.action)
            
            RxKeyboard.instance.visibleHeight
                .skip(1)
                .drive(with: self,
                   onNext: { this, keyboardHeight in
                    this.scrollView.contentInset.bottom = keyboardHeight
                })
        }
    }
    
    private func bindState(with reactor: SignUpInfomationReactor) {
        disposeBag.insert {
            reactor.state
                .map { $0.isManSelected }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(manButton.rx.isSelected)
        
            reactor.state
                .map { $0.isWomanSelected }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(womanButton.rx.isSelected)
        
            reactor.state
                .map { $0.isNextButtonEnabled }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(with: self,
                   onNext: { this, isEnabled in
                    this.nextButton.isEnabled = isEnabled
                    if isEnabled {
                        this.nextButton.becomeFirstResponder()
                    }
                })
        }
    }
    
    func bind(reactor: SignUpInfomationReactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
}
