//
//  SignUpAgreementViewController.swift
//  App
//
//  Created by Hani on 2022/05/24.
//

import UIKit

import ReactorKit
import RxCocoa

final class SignUpAgreementViewController: BaseViewController {
    private var guidanceLabel: UILabel = {
        let text = "서비스 이용을 위해\n약관 동의가 필요해요."
        let boldFont = UIFont.boldSystemFont(ofSize: 32)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.font, value: boldFont, range: (text as NSString).range(of: "약관 동의"))
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32)
        label.textColor = .Togaether.primaryLabel
        label.attributedText = attributedText
        label.numberOfLines = 0
        
        return label
    }()
    
    private var tosAndPrivacyPolicyCheckBox: UIButton = {
        let image = UIImage(systemName: "checkmark.circle")?
            .withTintColor(.Togaether.checkBoxNotHighlighted)
            .withRenderingMode(.alwaysOriginal)
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 36))
        
        let highlightedImage = UIImage(systemName: "checkmark.circle.fill")?
            .withTintColor(.Togaether.mainGreen)
            .withRenderingMode(.alwaysOriginal)
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 36))
                               
        let checkBox = UIButton()
        checkBox.setImage(image, for: .normal)
        checkBox.setImage(highlightedImage, for: .selected)
        
        return checkBox
    }()
    
    private var tosAndPrivacyPolicyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .Togaether.primaryLabel
        label.text = "모든 약관에 동의합니다."
        
        return label
    }()
    
    private lazy var checkBoxContourView: UIView = {
        let contour = UIView()
        contour.backgroundColor = .Togaether.contour
        
        return contour
    }()
    
    private var tosCheckBox: UIButton = {
        let image = UIImage(systemName: "checkmark.circle")?
            .withTintColor(.Togaether.checkBoxNotHighlighted)
            .withRenderingMode(.alwaysOriginal)
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 36))
        
        let highlightedImage = UIImage(systemName: "checkmark.circle.fill")?
            .withTintColor(.Togaether.mainGreen)
            .withRenderingMode(.alwaysOriginal)
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 36))
                               
        let checkBox = UIButton(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        checkBox.setImage(image, for: .normal)
        checkBox.setImage(highlightedImage, for: .highlighted)
        
        return checkBox
    }()
    
    private var tosLabel: UILabel = {
        let text = "서비스 이용약관에 동의합니다. [필수]"
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: (text as NSString).range(of: "서비스 이용약관"))
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .Togaether.primaryLabel
        label.attributedText = attributedText
        
        return label
    }()
    
    private var privacyPolicyCheckBox: UIButton = {
        let image = UIImage(systemName: "checkmark.circle")?
            .withTintColor(.Togaether.checkBoxNotHighlighted)
            .withRenderingMode(.alwaysOriginal)
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 36))
        
        let highlightedImage = UIImage(systemName: "checkmark.circle.fill")?
            .withTintColor(.Togaether.mainGreen)
            .withRenderingMode(.alwaysOriginal)
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 36))
                               
        let checkBox = UIButton(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        checkBox.setImage(image, for: .normal)
        checkBox.setImage(highlightedImage, for: .highlighted)
        
        return checkBox
    }()
    
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
        contour.backgroundColor = .Togaether.contour
        
        return contour
    }()

    private var nextButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = .Togaether.mainGreen
        button.setTitle("다음", for: .normal)
        button.isEnabled = false
        
        return button
    }()
    
    var disposeBag = DisposeBag()

    init(reactor: SignUpAgreementReactor) {
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
        
        if let reactor = reactor {
            bind(reactor: reactor)
        }
    }

    private func addSubviews() {
        view.addSubview(guidanceLabel)
        
        view.addSubview(tosAndPrivacyPolicyCheckBox)
        view.addSubview(tosAndPrivacyPolicyLabel)
        
        view.addSubview(checkBoxContourView)
        
        view.addSubview(tosCheckBox)
        view.addSubview(tosLabel)
        
        view.addSubview(privacyPolicyCheckBox)
        view.addSubview(privacyPolicyLabel)
        
        view.addSubview(nextButtonContourView)
        
        view.addSubview(nextButton)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            guidanceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 96),
            guidanceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            guidanceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            tosAndPrivacyPolicyCheckBox.topAnchor.constraint(equalTo: guidanceLabel.bottomAnchor, constant: 78),
            tosAndPrivacyPolicyCheckBox.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 22),
            tosAndPrivacyPolicyCheckBox.heightAnchor.constraint(equalToConstant: 36),
            tosAndPrivacyPolicyCheckBox.widthAnchor.constraint(equalToConstant: 36),
            tosAndPrivacyPolicyLabel.leadingAnchor.constraint(equalTo: tosAndPrivacyPolicyCheckBox.trailingAnchor, constant: 10),
            tosAndPrivacyPolicyLabel.centerYAnchor.constraint(equalTo: tosAndPrivacyPolicyCheckBox.centerYAnchor),
 
            checkBoxContourView.topAnchor.constraint(equalTo: tosAndPrivacyPolicyCheckBox.bottomAnchor, constant: 14),
            checkBoxContourView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            checkBoxContourView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            checkBoxContourView.heightAnchor.constraint(equalToConstant: 1),
            
            tosCheckBox.topAnchor.constraint(equalTo: checkBoxContourView.bottomAnchor, constant: 14),
            tosCheckBox.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 22),
            tosCheckBox.heightAnchor.constraint(equalToConstant: 36),
            tosCheckBox.widthAnchor.constraint(equalToConstant: 36),
            tosLabel.leadingAnchor.constraint(equalTo: tosCheckBox.trailingAnchor, constant: 10),
            tosLabel.centerYAnchor.constraint(equalTo: tosCheckBox.centerYAnchor),

            privacyPolicyCheckBox.topAnchor.constraint(equalTo: tosCheckBox.bottomAnchor, constant: 16),
            privacyPolicyCheckBox.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 22),
            privacyPolicyCheckBox.heightAnchor.constraint(equalToConstant: 36),
            privacyPolicyCheckBox.widthAnchor.constraint(equalToConstant: 36),
            privacyPolicyLabel.leadingAnchor.constraint(equalTo: privacyPolicyCheckBox.trailingAnchor, constant: 10),
            privacyPolicyLabel.centerYAnchor.constraint(equalTo: privacyPolicyCheckBox.centerYAnchor),
            
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
    
    private func bindAction(with reactor: SignUpAgreementReactor) {
        
    }
    
    private func bindState(with reactor: SignUpAgreementReactor) {
        
    }
    
    func bind(reactor: SignUpAgreementReactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
}
