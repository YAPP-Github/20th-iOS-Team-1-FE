//
//  SearchViewController.swift
//  App
//
//  Created by 유한준 on 2022/06/04.
//

import UIKit

import ReactorKit
import RxSwift

final class SearchViewController: BaseViewController {
    var disposeBag = DisposeBag()
    
    init(reactor: SearchReactor) {
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
        
    }
    
    private func bindAction(with reactor: SearchReactor) {
        disposeBag.insert {
            
        }
    }
    
    private func bindState(with reactor: SearchReactor) {
        disposeBag.insert {
            
        }
    }
    
    func bind(reactor: SearchReactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
}
