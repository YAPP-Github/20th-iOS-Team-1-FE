//
//  AuthViewController.swift
//  App
//
//  Created by Hani on 2022/05/01.
//

import UIKit

import ReactorKit
import RxCocoa

final class AuthViewController: BaseViewController {
    var disposeBag = DisposeBag()
    
    init(reactor: AuthReactor) {
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
        view.backgroundColor = .blue
    }
    
    private func bindAction(with reactor: AuthReactor) {
        
    }
    
    private func bindState(with reactor: AuthReactor) {
        
    }
    
    func bind(reactor: AuthReactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
}
