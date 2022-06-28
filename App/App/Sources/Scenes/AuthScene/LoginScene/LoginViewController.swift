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
                .map { LoginReactor.Action.signInWithApple(authorization: $0) }
                .bind(to: reactor.action)
        }
    }
    
    private func bindState(with reactor: LoginReactor) {
        disposeBag.insert {
            reactor.state
                .map { $0.isReadyToProceedWithSignUp }
                .filter { $0 == true }
                .observe(on: MainScheduler.instance)
                .subscribe(with: self,
                   onNext: { this, isEnabled in
                    let signUpAgreementReactor = SignUpAgreementReactor()
                    let signUpAgreementViewController = SignUpAgreementViewController(reactor: signUpAgreementReactor)
                    this.navigationController?.pushViewController(signUpAgreementViewController, animated: true)
                })
        }
    }
    
    func bind(reactor: LoginReactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
}
