//
//  SignUpAreaViewController.swift
//  App
//
//  Created by Hani on 2022/06/25.
//

import UIKit

import ReactorKit
import RxSwift

final class SignUpAreaViewController: BaseViewController {
    typealias Reactor = SignUpAreaReactor
    
    private let contentView = UIView()
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.keyboardDismissMode = .onDrag
        
        return scrollView
    }()
    
    private lazy var guidanceLabel: UILabel = {
        let text = "활동 지역을\n알려주세요."
        let boldFont = UIFont.boldSystemFont(ofSize: 32)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.font, value: boldFont, range: (text as NSString).range(of: "활동 지역"))
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32)
        label.textColor = .Togaether.primaryLabel
        label.attributedText = attributedText
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private lazy var bigCityLabel: UILabel = {
        let label = UILabel()
        label.text = "시/도"
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    private var bigCityPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        
        return pickerView
    }()
    
    private lazy var bigCityTextField: UITextField = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        
        let textField = UITextField()
        textField.inputView = bigCityPickerView
        textField.rightView = button
        textField.rightViewMode = .always
        
        return textField
    }()
    
    private lazy var bigCityContourView = ContourView()
    
    private lazy var smallCityLabel: UILabel = {
        let label = UILabel()
        label.text = "시/군/구"
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    private var smallCityPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        
        return pickerView
    }()
    
    private lazy var smallCityTextField: UITextField = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        
        let textField = UITextField()
        textField.inputView = smallCityPickerView
        textField.rightView = button
        textField.rightViewMode = .always
        
        return textField
    }()
    
    private lazy var smallCityContourView = ContourView()
    
    private lazy var nextButtonContourView = ContourView()

    private lazy var nextButton: EnableButton = {
        let button = EnableButton()
        button.setTitle("투개더 시작하기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        
        return button
    }()
    
    var disposeBag = DisposeBag()
    
    init(reactor: Reactor) {
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
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        contentView.endEditing(true)
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(guidanceLabel)
        
        contentView.addSubview(bigCityLabel)
        contentView.addSubview(bigCityTextField)
        contentView.addSubview(bigCityContourView)
        
        contentView.addSubview(smallCityLabel)
        contentView.addSubview(smallCityTextField)
        contentView.addSubview(smallCityContourView)
 
        view.addSubview(nextButtonContourView)
        view.addSubview(nextButton)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -4),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            
            nextButtonContourView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            nextButtonContourView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            nextButtonContourView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -14),
            nextButtonContourView.heightAnchor.constraint(equalToConstant: 1),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: nextButtonContourView.topAnchor, constant: -14),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor),
            
            guidanceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 96),
            guidanceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            guidanceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            bigCityLabel.topAnchor.constraint(equalTo: guidanceLabel.bottomAnchor, constant: 72),
            bigCityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            bigCityTextField.topAnchor.constraint(equalTo: bigCityLabel.bottomAnchor, constant: 14),
            bigCityTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            bigCityTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            bigCityContourView.topAnchor.constraint(equalTo: bigCityTextField.bottomAnchor, constant: 16),
            bigCityContourView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            bigCityContourView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            bigCityContourView.heightAnchor.constraint(equalToConstant: 1),
            
            smallCityLabel.topAnchor.constraint(equalTo: bigCityContourView.bottomAnchor, constant: 45),
            smallCityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            smallCityTextField.topAnchor.constraint(equalTo: smallCityLabel.bottomAnchor, constant: 14),
            smallCityTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            smallCityTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            smallCityContourView.topAnchor.constraint(equalTo: smallCityTextField.bottomAnchor, constant: 16),
            smallCityContourView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            smallCityContourView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            smallCityContourView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .Togaether.background
        scrollView.backgroundColor = .Togaether.background
    }
    
    private func bindAction(with reactor: Reactor) {
        disposeBag.insert {
            bigCityTextField.rx.controlEvent([.touchUpInside])
                .map { Reactor.Action.bigCityTextFieldDidTap }
                .bind(to: reactor.action)
                  
            bigCityPickerView.rx.itemSelected
                .map { Reactor.Action.bigCityDidPick($0.row) }
                .bind(to: reactor.action)
            
            smallCityTextField.rx.controlEvent([.touchUpInside])
                .map { Reactor.Action.smallCityTextFieldDidTap }
                .bind(to: reactor.action)
            
            smallCityPickerView.rx.itemSelected
                .map { Reactor.Action.smallCityDidPick($0.row) }
                .bind(to: reactor.action)
            
            nextButton.rx.throttleTap
                .map { Reactor.Action.nextButtonDidTap }
                .bind(to: reactor.action)
        }
    }
  
    private func bindState(with reactor: Reactor) {
        disposeBag.insert {
            reactor.state
                .map { $0.bigCityList }
                .asDriver(onErrorJustReturn: [])
                .drive(bigCityPickerView.rx.itemTitles) { (row, element) in return element }

            reactor.state
                .map { $0.selectedBigCity }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: nil)
                .drive(bigCityTextField.rx.text)

            
            reactor.state
                .map { $0.smallCityList }
                .asDriver(onErrorJustReturn: [])
                .drive(smallCityPickerView.rx.itemTitles) { (row, element) in return element }

            reactor.state
                .map { $0.selectedSmallCity }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: nil)
                .drive(smallCityTextField.rx.text)

            reactor.state
                .map { $0.isNextButtonEnabled }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(with: self,
                   onNext: { this, isEnabled in
                    this.nextButton.isEnabled = isEnabled
                    if isEnabled {
                        this.nextButton.becomeFirstResponder()
                    }
                })
        }
    }
    
    func bind(reactor: Reactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
}
