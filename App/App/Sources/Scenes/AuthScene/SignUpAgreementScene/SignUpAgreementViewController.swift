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
        
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
        
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .brown
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
