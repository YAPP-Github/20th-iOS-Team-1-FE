//
//  CreateGatherViewController.swift
//  App
//
//  Created by 김나희 on 7/25/22.
//

import UIKit

import ReactorKit
import RxCocoa

final class CreateGatherViewController: BaseViewController {
    var disposeBag = DisposeBag()
    
    init(reactor: CreateGatherReactor) {
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

        view.backgroundColor = .red
    }

    private func addSubviews() {
        
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
        
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .green
    }
    
    private func bindAction(with reactor: CreateGatherReactor) {
        
    }
    
    private func bindState(with reactor: CreateGatherReactor) {
        
    }
    
    func bind(reactor: CreateGatherReactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
}
