//___FILEHEADER___

import UIKit

import ReactorKit
import RxCocoa

final class ___FILEBASENAMEIDENTIFIER___: BaseViewController {
    init(reactor: ___VARIABLE_productName:identifier___Reactor) {
        self.reactor = reactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        configureLayout()
        configureUI()
        bind(reactor: reactor)
    }

    private func addSubviews() {
        
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
        
        ])
    }
    
    private func configureUI() {
        
    }
    
    private func bindAction(with reactor: ___VARIABLE_productName:identifier___Reactor) {
        
    }
    
    private func bindState(with reactor: ___VARIABLE_productName:identifier___Reactor) {
        
    }
    
    func bind(reactor: ___VARIABLE_productName:identifier___Reactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
}
