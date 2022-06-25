//
//  SignUpInfomationViewController.swift
//  App
//
//  Created by Hani on 2022/06/03.
//

import UIKit

import ReactorKit
import RxSwift

final class SignUpInfomationViewController: BaseViewController {
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
        label.numberOfLines = 0
        
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

    private func addSubviews() {
        view.addSubview(guidanceLabel)
        
        view.addSubview(ageLabel)
        view.addSubview(ageTextField)
        view.addSubview(ageContourView)
        
        view.addSubview(sexLabel)
        view.addSubview(sexStackView)
        sexStackView.addArrangedSubview(manButton)
        sexStackView.addArrangedSubview(womanButton)
        
        view.addSubview(nextButtonContourView)
        view.addSubview(nextButton)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            guidanceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 96),
            guidanceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            guidanceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            ageLabel.topAnchor.constraint(equalTo: guidanceLabel.bottomAnchor, constant: 72),
            ageLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            ageTextField.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 20),
            ageTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            ageContourView.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 15),
            ageContourView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            ageContourView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            sexLabel.topAnchor.constraint(equalTo: ageContourView.bottomAnchor, constant: 44),
            sexLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            sexStackView.topAnchor.constraint(equalTo: sexLabel.bottomAnchor, constant: 20),
            sexStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            sexStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            sexStackView.heightAnchor.constraint(equalToConstant: 44),
            
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -4),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            
            nextButtonContourView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            nextButtonContourView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            nextButtonContourView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -14),
            nextButtonContourView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .Togaether.background
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
                .drive(nextButton.rx.isEnabled)
        }
    }
    
    func bind(reactor: SignUpInfomationReactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
}
