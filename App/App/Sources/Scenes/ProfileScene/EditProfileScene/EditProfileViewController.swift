//
//  EditProfileViewController.swift
//  App
//
//  Created by 김나희 on 6/30/22.
//

import UIKit

import ReactorKit
import RxCocoa

final class EditProfileViewController: BaseViewController {
    private var guidanceLabel: UILabel = {
        let text = "나와 반려견을\n소개해 주세요."
        let boldFont = UIFont.customFont(size: 28, style: .Bold)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.font, value: boldFont, range: (text as NSString).range(of: "나와 반려견"))
        let label = UILabel()
        label.font = UIFont.customFont(size: 28, style: .Medium)
        label.textColor = .Togaether.primaryLabel
        label.attributedText = attributedText
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private lazy var introduceLabel: UILabel = {
        let label = UILabel()
        label.text = "자기소개"
        label.font = UIFont.customFont(size: 14, style: .Medium)
        
        return label
    }()
    
    private lazy var introduceTextView: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 12
        textView.text = "내용을 입력해주세요."
        textView.textContainerInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        textView.font = UIFont.customFont(size: 14, style: .Medium)
        textView.textColor = UIColor.Togaether.secondaryLabel
        textView.backgroundColor = UIColor.Togaether.divider
        textView.delegate = self

        return textView
    }()
    
    private lazy var countLettersLabel: UILabel = {
        let label = UILabel()
        label.text = "0/60자"
        label.font = UIFont.customFont(size: 14, style: .Medium)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private let registerButtonDivider = Divider()
    
    private let registerButton: EnableButton = {
        let button = EnableButton()
        button.setTitle("자기소개 등록", for: .normal)
        button.isEnabled = false
        
        return button
    }()
    
    var disposeBag = DisposeBag()
    
    init(reactor: EditProflieReactor) {
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
        view.addSubview(introduceLabel)
        view.addSubview(introduceTextView)
        view.addSubview(countLettersLabel)
        view.addSubview(registerButtonDivider)
        view.addSubview(registerButton)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            guidanceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            guidanceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 19),
            guidanceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            introduceLabel.topAnchor.constraint(equalTo: guidanceLabel.bottomAnchor, constant: 40),
            introduceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 21),
            
            introduceTextView.topAnchor.constraint(equalTo: introduceLabel.bottomAnchor, constant: 20),
            introduceTextView.leadingAnchor.constraint(equalTo: introduceLabel.leadingAnchor),
            introduceTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            introduceTextView.heightAnchor.constraint(equalToConstant: 152),

            countLettersLabel.trailingAnchor.constraint(equalTo: introduceTextView.trailingAnchor, constant: -20),
            countLettersLabel.bottomAnchor.constraint(equalTo: introduceTextView.bottomAnchor, constant: -20),
            
            registerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            registerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -4),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            
            registerButtonDivider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            registerButtonDivider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            registerButtonDivider.bottomAnchor.constraint(equalTo: registerButton.topAnchor, constant: -8),
            registerButtonDivider.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .Togaether.background
    }
    
    private func bindAction(with reactor: EditProflieReactor) {
        disposeBag.insert {
            introduceTextView.rx.text
                .orEmpty
                .distinctUntilChanged()
                .map { Reactor.Action.textViewEndEditing($0) }
                .bind(to: reactor.action )
            
            registerButton.rx.throttleTap
                .map { Reactor.Action.registerButtonDidTap }
                .bind(to: reactor.action)
        }
    }
    
    private func bindState(with reactor: EditProflieReactor) {
        disposeBag.insert {
            reactor.state
                .map { $0.isRegisterButtonEnabled }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(with: self,
                   onNext: { this, isEnabled in
                    this.registerButton.isEnabled = isEnabled
                    if isEnabled {
                        this.registerButton.becomeFirstResponder()
                    }
                })
        
        }
    }
    
    func bind(reactor: EditProflieReactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension EditProfileViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .Togaether.secondaryLabel else { return }
        textView.textColor = .Togaether.primaryLabel
        textView.text = nil
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "내용을 입력해주세요."
            textView.textColor = .Togaether.secondaryLabel
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let currentRange = Range(range, in: currentText) else {
            return false
        }
        let changeText = currentText.replacingCharacters(in: currentRange, with: text)
        
        countLettersLabel.text = "(\(changeText.count)/60자)"
        return changeText.count < 60
    }
}
