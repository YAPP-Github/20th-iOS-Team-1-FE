//
//  ProfileViewController.swift
//  App
//
//  Created by Hani on 2022/05/01.
//

import UIKit

import ReactorKit
import RxCocoa

final class ProfileViewController: BaseViewController {
    var disposeBag = DisposeBag()
    
    init(reactor: ProfileReactor) {
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
        
    }
    
    private func bindAction(with reactor: ProfileReactor) {
        
    }
    
    private func bindState(with reactor: ProfileReactor) {
        
    }
    
    func bind(reactor: ProfileReactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
}
