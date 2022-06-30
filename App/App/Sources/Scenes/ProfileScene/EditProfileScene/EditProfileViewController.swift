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
        
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
        
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .blue
    }
    
    private func bindAction(with reactor: EditProflieReactor) {
        
    }
    
    private func bindState(with reactor: EditProflieReactor) {
        
    }
    
    func bind(reactor: EditProflieReactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
}
