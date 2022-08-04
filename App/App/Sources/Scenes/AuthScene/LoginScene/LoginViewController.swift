//
//  LoginViewController.swift
//  App
//
//  Created by Hani on 2022/05/01.
//

import AuthenticationServices
import UIKit

import ReactorKit
import RxSwift

final class LoginViewController: BaseViewController {
    private lazy var guidanceLabel: UILabel = {
        let text = "반려견 모임을 더 쉽고 즐겁개"
        let boldFont = UIFont.boldSystemFont(ofSize: 20)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.font, value: UIFont.customFont(size: 20, style: .Bold), range: (text as NSString).range(of: "더 쉽고 즐겁개"))
        
        let label = UILabel()
        label.font = .customFont(size: 20)
        label.textColor = .Togaether.primaryLabel
        label.attributedText = attributedText
        label.adjustsFontSizeToFitWidth = true
    
        return label
    }()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .Togaether.logo
        
        return imageView
    }()
    
    private lazy var signInWithAppleButton: ASAuthorizationAppleIDButton = {
        if UITraitCollection.current.userInterfaceStyle == .light {
            return ASAuthorizationAppleIDButton(type: .continue, style: .black)
        }
        
        return ASAuthorizationAppleIDButton(type: .continue, style: .white)
    }()
    
    var disposeBag = DisposeBag()
    
    init(reactor: LoginReactor) {
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
        view.addSubview(logoImageView)
        view.addSubview(signInWithAppleButton)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            NSLayoutConstraint(item: logoImageView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 0.9, constant: 0.0),
            
            guidanceLabel.bottomAnchor.constraint(equalTo: logoImageView.topAnchor),
            guidanceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            signInWithAppleButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            signInWithAppleButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            signInWithAppleButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -4),
            signInWithAppleButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .Togaether.background
        navigationController?.navigationBar.isTranslucent = true
    }
    
    private func bindAction(with reactor: LoginReactor) {
        disposeBag.insert {
            signInWithAppleButton.rx.tap(scopes: [])
                .map { LoginReactor.Action.signInWithApple(authorization: $0) }
                .bind(to: reactor.action)
        }
    }
    
    private func bindState(with reactor: LoginReactor) { }
    
    func bind(reactor: LoginReactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
}
