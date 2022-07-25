//
//  CreateGatherView.swift
//  App
//
//  Created by 김나희 on 7/25/22.
//

import UIKit

import RxCocoa
import RxSwift

final class CreateGatherView: UIView {
    let disposeBag = DisposeBag()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "모임 위치"
        label.font = .customFont(size: 14, style: .Medium)
        label.textColor = .Togaether.primaryLabel
        
        return label
    }()
    
    internal lazy var addressTextField: UITextField = {
        let textField = UITextField()
        textField.font = .customFont(size: 16, style: .Medium)
        textField.textColor = .Togaether.primaryLabel
        textField.textAlignment = .center
        textField.backgroundColor = .Togaether.divider
        textField.layer.cornerRadius = 15
        
        return textField
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "모임 카테고리"
        label.font = .customFont(size: 14, style: .Medium)
        label.textColor = .Togaether.primaryLabel
        
        return label
    }()
    
    private let categorySelectView = CategorySelectView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "모임 제목"
        label.font = .customFont(size: 14, style: .Medium)
        label.textColor = .Togaether.primaryLabel
        
        return label
    }()

    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "입력해주세요."
        textField.font = .customFont(size: 16, style: .Medium)
        textField.textColor = .Togaether.primaryLabel
        
        return textField
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "모임 내용"
        label.font = .customFont(size: 14, style: .Medium)
        label.textColor = .Togaether.primaryLabel
        
        return label
    }()

    internal lazy var cotentTextView: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 12
        textView.text = "내용을 입력해주세요."
        textView.textContainerInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        textView.font = UIFont.customFont(size: 14, style: .Medium)
        textView.textColor = UIColor.Togaether.secondaryLabel
        textView.backgroundColor = UIColor.Togaether.divider
        textView.delegate = self

        return textView
    }()
    
    private lazy var countLettersLabel: UILabel = {
        let label = UILabel()
        label.text = "(0/200자)"
        label.font = UIFont.customFont(size: 14, style: .Medium)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private lazy var startDateLabel: UILabel = {
        let label = UILabel()
        label.text = "모임 시작"
        label.font = UIFont.customFont(size: 14, style: .Medium)
        
        return label
    }()
    
    internal lazy var startDateTextField: UITextField = {
        let textField = TextFieldWithDatePicker(frame: .zero, type: .date)
        textField.textColor = .white
        textField.backgroundColor = .Togaether.mainGreen
        textField.layer.cornerRadius = 15
        
        return textField
    }()
        
    internal lazy var startTimeTextField: UITextField = {
        let textField = TextFieldWithDatePicker(frame: .zero, type: .time)
        textField.textColor = .Togaether.primaryLabel
        textField.backgroundColor = .Togaether.divider
        textField.layer.cornerRadius = 15
        
        return textField
    }()
    
    private lazy var startStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [startDateTextField, startTimeTextField])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        return stackView
    }()
    
    private lazy var endDateLabel: UILabel = {
        let label = UILabel()
        label.text = "모임 종료"
        label.font = UIFont.customFont(size: 14, style: .Medium)
        
        return label
    }()
    
    internal lazy var endDateTextField: UITextField = {
        let textField = TextFieldWithDatePicker(frame: .zero, type: .date)
        textField.textColor = .white
        textField.backgroundColor = .Togaether.mainGreen
        textField.layer.cornerRadius = 15
        
        return textField
    }()
        
    internal lazy var endTimeTextField: UITextField = {
        let textField = TextFieldWithDatePicker(frame: .zero, type: .time)
        textField.textColor = .Togaether.primaryLabel
        textField.backgroundColor = .Togaether.divider
        textField.layer.cornerRadius = 15

        return textField
    }()
    
    private lazy var endStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [endDateTextField, endTimeTextField])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        return stackView
    }()
    
    private lazy var numberOfPeopleLabel: UILabel = {
        let label = UILabel()
        label.text = "모임 인원수"
        label.font = .customFont(size: 14, style: .Medium)
        label.textColor = .Togaether.primaryLabel
        
        return label
    }()
    
    private lazy var numberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "최대 10"
        textField.font = .customFont(size: 18, style: .Medium)
        textField.keyboardType = .numberPad
        textField.textColor = .Togaether.primaryLabel
        textField.textAlignment = .center

        return textField
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.text = "명"
        label.font = .customFont(size: 18, style: .Medium)
        label.textColor = .Togaether.primaryLabel
        
        return label
    }()
    
    private lazy var sexLabel: UILabel = {
        let label = UILabel()
        label.text = "견주 성별 제한"
        label.font = .customFont(size: 14, style: .Medium)
        label.textColor = .Togaether.primaryLabel
        
        return label
    }()
    
    internal lazy var allButton: BorderButton = {
        let button = BorderButton()
        button.setTitle("성별 무관", for: .normal)
        button.titleLabel?.font = UIFont.customFont(size: 16, style: .Medium)
        button.isSelected = false
        
        return button
    }()
    
    internal lazy var manButton: BorderButton = {
        let button = BorderButton()
        button.setTitle("남성 Only", for: .normal)
        button.titleLabel?.font = UIFont.customFont(size: 16, style: .Medium)
        button.isSelected = false
        
        return button
    }()
    
    internal lazy var womanButton: BorderButton = {
        let button = BorderButton()
        button.setTitle("여성 Only", for: .normal)
        button.titleLabel?.font = UIFont.customFont(size: 16, style: .Medium)
        button.isSelected = false
        
        return button
    }()
    
    private lazy var sexStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [allButton, manButton, womanButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        return stackView
    }()
    
    private lazy var petSizeLabel: UILabel = {
        let label = UILabel()
        let text = "참여 가능 반려견 크기\n\n복수 선택이 가능합니다."
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.foregroundColor, value: UIColor.Togaether.mainGreen, range: (text as NSString).range(of:"복수 선택이 가능합니다."))
        label.font = UIFont.customFont(size: 14, style: .Medium)
        label.attributedText = attributedText
        label.numberOfLines = 0
        
        return label
    }()
    
    internal lazy var smallPetButton: PetSizeButton = {
        let button = PetSizeButton(sizeType: .small, frame: .zero)
        button.isSelected = false
        
        return button
    }()
    
    internal lazy var middlePetButton: PetSizeButton = {
        let button = PetSizeButton(sizeType: .middle, frame: .zero)
        button.isSelected = false

        return button
    }()
    
    internal lazy var largePetButton: PetSizeButton = {
        let button = PetSizeButton(sizeType: .large, frame: .zero)
        button.isSelected = false

        return button
    }()
    
    private lazy var petSizeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [smallPetButton, middlePetButton, largePetButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        
        return stackView
    }()
    
    
    private lazy var breedLabel: UILabel = {
        let label = UILabel()
        let text = "참여 가능 견종\n\n견종을 선택하지 않으면, 모든 견종이 참여할 수 있습니다."
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.foregroundColor, value: UIColor.Togaether.mainGreen, range: (text as NSString).range(of:"견종을 선택하지 않으면, 모든 견종이 참여할 수 있습니다."))
        label.font = UIFont.customFont(size: 14, style: .Medium)
        label.attributedText = attributedText
        label.numberOfLines = 0
        
        return label
    }()
    
    internal lazy var searchBreedBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.barTintColor = UIColor.Togaether.secondaryButton
        searchBar.searchTextField.font = UIFont.customFont(size: 15, style: .Regular)
        searchBar.placeholder = "견종 검색하기"
        searchBar.setImage(UIImage.Togaether.breedSearchIcon, for: UISearchBar.Icon.search, state: .normal)
        
        return searchBar
    }()
    
    private lazy var breedCollectionView: TagCollectionView = {
        let collectionView = TagCollectionView(reactor: TagCollectionViewReactor(state: []), frame: .zero)
        
        return collectionView
    }()
    
    private let addButtonDivider = Divider()
    
    internal let addButton: EnableButton = {
        let button = EnableButton()
        button.setTitle("모임 생성하기", for: .normal)
        button.isEnabled = false

        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configureLayout()
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(locationLabel)
        addSubview(addressTextField)
        addSubview(categoryLabel)
        addSubview(categorySelectView)
        addSubview(titleLabel)
        addSubview(titleTextField)
        addSubview(contentLabel)
        addSubview(cotentTextView)
        addSubview(countLettersLabel)
        addSubview(startDateLabel)
        addSubview(startStackView)
        addSubview(endDateLabel)
        addSubview(endStackView)
        addSubview(numberOfPeopleLabel)
        addSubview(numberTextField)
        addSubview(numberLabel)
        addSubview(sexLabel)
        addSubview(sexStackView)
        addSubview(petSizeLabel)
        addSubview(petSizeStackView)
        addSubview(breedLabel)
        addSubview(searchBreedBar)
        addSubview(breedCollectionView)
        addSubview(addButtonDivider)
        addSubview(addButton)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            locationLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            locationLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 21),
            
            addressTextField.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 20),
            addressTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            addressTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addressTextField.heightAnchor.constraint(equalToConstant: 50),
            
            categoryLabel.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 44),
            categoryLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            
            categorySelectView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 20),
            categorySelectView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            categorySelectView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            categorySelectView.heightAnchor.constraint(greaterThanOrEqualToConstant: 250),
            
            titleLabel.topAnchor.constraint(equalTo: categorySelectView.bottomAnchor, constant: 44),
            titleLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            contentLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 44),
            contentLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            
            cotentTextView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 20),
            cotentTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            cotentTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            cotentTextView.heightAnchor.constraint(equalToConstant: 150),
            
            countLettersLabel.trailingAnchor.constraint(equalTo: cotentTextView.trailingAnchor, constant: -20),
            countLettersLabel.bottomAnchor.constraint(equalTo: cotentTextView.bottomAnchor, constant: -20),
            
            startDateLabel.topAnchor.constraint(equalTo: cotentTextView.bottomAnchor, constant: 44),
            startDateLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            
            startStackView.topAnchor.constraint(equalTo: startDateLabel.bottomAnchor, constant: 20),
            startStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            startStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            startStackView.heightAnchor.constraint(equalToConstant: 40),
            
            endDateLabel.topAnchor.constraint(equalTo: startStackView.bottomAnchor, constant: 44),
            endDateLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            
            endStackView.topAnchor.constraint(equalTo: endDateLabel.bottomAnchor, constant: 30),
            endStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            endStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            endStackView.heightAnchor.constraint(equalToConstant: 40),
            
            numberOfPeopleLabel.topAnchor.constraint(equalTo: endStackView.bottomAnchor, constant: 44),
            numberOfPeopleLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            
            numberTextField.topAnchor.constraint(equalTo: numberOfPeopleLabel.bottomAnchor, constant: 20),
            numberTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            numberLabel.leadingAnchor.constraint(equalTo: numberTextField.trailingAnchor, constant: 5),
            numberLabel.centerYAnchor.constraint(equalTo: numberTextField.centerYAnchor),
            
            sexLabel.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 44),
            sexLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            
            sexStackView.topAnchor.constraint(equalTo: sexLabel.bottomAnchor, constant: 20),
            sexStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            sexStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            sexStackView.heightAnchor.constraint(equalToConstant: 40),

            
            petSizeLabel.topAnchor.constraint(equalTo: sexStackView.bottomAnchor, constant: 44),
            petSizeLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            
            petSizeStackView.topAnchor.constraint(equalTo: petSizeLabel.bottomAnchor, constant: 20),
            petSizeStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            petSizeStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            petSizeStackView.heightAnchor.constraint(equalToConstant: 120),

            
            breedLabel.topAnchor.constraint(equalTo: petSizeStackView.bottomAnchor, constant: 44),
            breedLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            
            searchBreedBar.topAnchor.constraint(equalTo: breedLabel.bottomAnchor, constant: 20),
            searchBreedBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            searchBreedBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            addButtonDivider.topAnchor.constraint(equalTo: searchBreedBar.bottomAnchor, constant: 90),
            addButtonDivider.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            addButtonDivider.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            addButtonDivider.heightAnchor.constraint(equalToConstant: 1),
            
            addButton.topAnchor.constraint(equalTo: addButtonDivider.bottomAnchor, constant: 8),
            addButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureUI() {
        backgroundColor = .Togaether.background
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
}

extension CreateGatherView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .Togaether.secondaryLabel else { return }
        textView.textColor = .Togaether.primaryLabel
        if textView.text == "내용을 입력해주세요." {
            textView.text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "내용을 입력해주세요."
            textView.textColor = .Togaether.secondaryLabel
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let currentRange = Range(range, in: currentText) else {
            return false
        }
        let changeText = currentText.replacingCharacters(in: currentRange, with: text)
        
        countLettersLabel.text = "(\(changeText.count)/200자)"
        return changeText.count < 200
    }
}
