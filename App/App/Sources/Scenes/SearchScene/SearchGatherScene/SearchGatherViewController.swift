//
//  SearchGatherViewController.swift
//  App
//
//  Created by 유한준 on 2022/07/09.
//

import UIKit

import ReactorKit
import RxSwift

final class SearchGatherViewController: BaseViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MyTapMethod))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(singleTapGestureRecognizer)
        
        return scrollView
    }()
    
    private let gatherSearchTextFieldView: GatherSearchTextFieldView =  GatherSearchTextFieldView()
    
    private var categorySearchDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "카테고리로 찾기"
        
        return label
    }()
    
    private let contentView = UIView()
    
    private let keyboardView: UIView = UIView()
    
    private lazy var keyboardHeightConstraint: NSLayoutConstraint = {
        let constraint = keyboardView.heightAnchor.constraint(equalToConstant: 0)
        
        constraint.isActive = true
        
        return constraint
    }()
    
    private let categorySelectView: CategorySelectView = CategorySelectView()
    
    var disposeBag = DisposeBag()
    
    init(reactor: SearchGatherReactor) {
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
        configureKeyboardNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gatherSearchTextFieldView.layer.addBorder([.bottom], color: UIColor.Togaether.line, width: 1)
    }

    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(gatherSearchTextFieldView)
        contentView.addSubview(categorySearchDescriptionLabel)
        contentView.addSubview(categorySelectView)
        contentView.addSubview(keyboardView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            //scrollView
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            //contentView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            //textField
            gatherSearchTextFieldView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            gatherSearchTextFieldView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            gatherSearchTextFieldView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            gatherSearchTextFieldView.heightAnchor.constraint(equalToConstant: 50),
            
            categorySearchDescriptionLabel.topAnchor.constraint(equalTo: gatherSearchTextFieldView.bottomAnchor, constant: 64),
            categorySearchDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
            categorySearchDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -21),
            categorySearchDescriptionLabel.heightAnchor.constraint(equalToConstant: 28),
            
            categorySelectView.topAnchor.constraint(equalTo: categorySearchDescriptionLabel.bottomAnchor, constant: 20),
            categorySelectView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            categorySelectView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            categorySelectView.heightAnchor.constraint(greaterThanOrEqualToConstant: 250),
            categorySelectView.bottomAnchor.constraint(equalTo: keyboardView.topAnchor),
            
            keyboardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            keyboardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            keyboardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .Togaether.background
        
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "모임 찾기"
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .Togaether.mainYellow
    }
    
    private func configureKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func MyTapMethod(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc func keyBoardWillShow(notification: NSNotification) {
           let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
           let keyboardRectangle = keyboardFrame.cgRectValue
           let keyboardHeight = keyboardRectangle.height

           self.keyboardHeightConstraint.constant = keyboardHeight
       }

       @objc func keyBoardWillHide(notification: NSNotification) {
           self.keyboardHeightConstraint.constant = 0
       }
    
    private func bindAction(with reactor: SearchGatherReactor) {
        disposeBag.insert {
            gatherSearchTextFieldView.textField.rx.text
                .orEmpty
                .distinctUntilChanged()
                .map { Reactor.Action.textFieldEditingChanged($0) }
                .bind(to: reactor.action)
            
            gatherSearchTextFieldView.textField.rx.controlEvent(.editingDidEndOnExit)
                .map { Reactor.Action.textFieldEditingDidEndOnExit }
                .bind(to: reactor.action)
        }
    }
    
    private func bindState(with reactor: SearchGatherReactor) { }
    
    func bind(reactor: SearchGatherReactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
}
