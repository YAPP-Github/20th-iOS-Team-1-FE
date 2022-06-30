//
//  AddPetViewController.swift
//  App
//
//  Created by 김나희 on 6/30/22.
//

import UIKit

import ReactorKit
import RxCocoa

final class AddPetViewController: BaseViewController {
    var disposeBag = DisposeBag()
    
    init(reactor: AddPetReactor) {
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
        
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
        
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .red
    }
    
    private func bindAction(with reactor: AddPetReactor) {
        
    }
    
    private func bindState(with reactor: AddPetReactor) {
        
    }
    
    func bind(reactor: AddPetReactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
}
