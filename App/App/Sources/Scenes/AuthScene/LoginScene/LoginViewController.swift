//
//  LoginViewController.swift
//  App
//
//  Created by Hani on 2022/05/01.
//

import AuthenticationServices
import UIKit

import ReactorKit
import RxCocoa

final class LoginViewController: BaseViewController {
    private var signInWithAppleButton = ASAuthorizationAppleIDButton()
    
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
        view.addSubview(signInWithAppleButton)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            signInWithAppleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInWithAppleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .Togaether.background
    }
    
    private func bindAction(with reactor: LoginReactor) {
        disposeBag.insert {
            signInWithAppleButton.rx.tap(scopes: [.email])
                .withUnretained(self)
                .compactMap { (owner, authorization) in owner.email(for: authorization) }
                .map { LoginReactor.Action.signInWithApple(email: $0) }
                .bind(to: reactor.action)
        }
    }
    
    private func bindState(with reactor: LoginReactor) {
        
    }
    
    private func email(for authorization: ASAuthorization) -> String? {
        let crendential = authorization.credential as? ASAuthorizationAppleIDCredential
        let email = crendential?.email
        
        return email
    }
    
    func bind(reactor: LoginReactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
}
