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
    
    private lazy var guidanceLabel: UILabel = {
        let text = "활동 지역을\n알려주세요."
        let boldFont = UIFont.boldSystemFont(ofSize: 32)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.font, value: boldFont, range: (text as NSString).range(of: "활동 지역"))
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32)
        label.textColor = .Togaether.primaryLabel
        label.attributedText = attributedText
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var bigCityLabel: UILabel = {
        let label = UILabel()
        label.text = "시/도"
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    private lazy var selectedBigCityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        
        return label
    }()
    
    private lazy var selectBigCityButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        
        return button
    }()
    
    private lazy var bigCityPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        
        return pickerView
    }()
    
    private var bigCityContourView = ContourView()
    
    private var smallCityLabel: UILabel = {
        let label = UILabel()
        label.text = "시/군/구"
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    private lazy var selectedSmallCityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        
        return label
    }()
    
    private lazy var selectSmallCityButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        
        return button
    }()
    
    private lazy var smallCityPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        
        return pickerView
    }()
    
    private var smallCityContourView = ContourView()
    
    private lazy var nextButtonContourView = ContourView()

    private var nextButton: EnableButton = {
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

    private func addSubviews() {
        view.addSubview(guidanceLabel)
        
        view.addSubview(bigCityLabel)
        view.addSubview(selectedBigCityLabel)
        view.addSubview(selectBigCityButton)
        view.addSubview(bigCityContourView)
        
        view.addSubview(smallCityLabel)
        view.addSubview(selectedSmallCityLabel)
        view.addSubview(selectSmallCityButton)
        view.addSubview(smallCityContourView)
 
        view.addSubview(nextButtonContourView)
        view.addSubview(nextButton)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            guidanceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 96),
            guidanceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            guidanceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            bigCityLabel.topAnchor.constraint(equalTo: guidanceLabel.bottomAnchor, constant: 72),
            bigCityLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            selectedBigCityLabel.topAnchor.constraint(equalTo: bigCityLabel.bottomAnchor, constant: 14),
            selectedBigCityLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            selectBigCityButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            selectBigCityButton.centerYAnchor.constraint(equalTo: selectedBigCityLabel.centerYAnchor),
            
            bigCityContourView.topAnchor.constraint(equalTo: selectedBigCityLabel.bottomAnchor, constant: 16),
            bigCityContourView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            bigCityContourView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            bigCityContourView.heightAnchor.constraint(equalToConstant: 1),
            
            smallCityLabel.topAnchor.constraint(equalTo: bigCityContourView.bottomAnchor, constant: 45),
            smallCityLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            selectedSmallCityLabel.topAnchor.constraint(equalTo: smallCityLabel.bottomAnchor, constant: 14),
            selectedSmallCityLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            selectSmallCityButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            selectSmallCityButton.centerYAnchor.constraint(equalTo: selectedSmallCityLabel.centerYAnchor),
            
            smallCityContourView.topAnchor.constraint(equalTo: selectedSmallCityLabel.bottomAnchor, constant: 16),
            smallCityContourView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            smallCityContourView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            smallCityContourView.heightAnchor.constraint(equalToConstant: 1),
            
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -4),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            
            nextButtonContourView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            nextButtonContourView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            nextButtonContourView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -14),
            nextButtonContourView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .Togaether.background
    }
    
    private func bindAction(with reactor: Reactor) {
        disposeBag.insert {
            selectBigCityButton.rx.throttleTap
                .map { Reactor.Action.selectBigCityButtonDidTap }
                .bind(to: reactor.action)
            
            bigCityPickerView.rx.itemSelected
                .map { Reactor.Action.bigCityDidPick($0.row) }
                .bind(to: reactor.action)
            
            selectSmallCityButton.rx.throttleTap
                .map { Reactor.Action.selectSmallCityButtonDidTap }
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
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: [])
                .drive(bigCityPickerView.rx.itemTitles) { (row, element) in return element }

            reactor.state
                .map { $0.selectedBigCity }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: nil)
                .drive(bigCityLabel.rx.text)
            
            reactor.state
                .compactMap { $0.smallCityList }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: [])
                .drive(smallCityPickerView.rx.itemTitles) { (row, element) in return element }

            reactor.state
                .map { $0.selectedSmallCity }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: nil)
                .drive(smallCityLabel.rx.text)

            reactor.state
                .map { $0.isNextButtonEnabled }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(nextButton.rx.isEnabled)
        }
    }
    
    func bind(reactor: Reactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
}
