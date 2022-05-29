//___FILEHEADER___

import UIKit

import ReactorKit
import RxSwift

final class ___FILEBASENAMEASIDENTIFIER___: BaseViewController {
    var disposeBag = DisposeBag()
    
    init(reactor: ___VARIABLE_productName:identifier___Reactor) {
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
    
    private func bindAction(with reactor: ___VARIABLE_productName:identifier___Reactor) {
        disposeBag.insert {
            
        }
    }
    
    private func bindState(with reactor: ___VARIABLE_productName:identifier___Reactor) {
        disposeBag.insert {
            
        }
    }
    
    func bind(reactor: ___VARIABLE_productName:identifier___Reactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
}
