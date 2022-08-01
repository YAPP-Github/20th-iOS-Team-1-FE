//
//  AddPetContentView.swift
//  App
//
//  Created by 김나희 on 7/9/22.
//

import UIKit

final class AddPetContentView: UIView {
    
    private var guidanceLabel: UILabel = {
        let text = "반려견의 정보를\n입력해 주세요."
        let boldFont = UIFont.customFont(size: 28, style: .Bold)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.font, value: boldFont, range: (text as NSString).range(of: "반려견의 정보"))
        let label = UILabel()
        label.font = UIFont.customFont(size: 28, style: .Medium)
        label.textColor = .Togaether.primaryLabel
        label.attributedText = attributedText
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    internal let profileImageButton: CircularButton = {
        let button = CircularButton()
        button.setBackgroundImage(.Togaether.userDefaultProfile, for: .normal)
        button.backgroundColor = .Togaether.background
        
        return button
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "반려견 이름"
        label.font = UIFont.customFont(size: 14, style: .Medium)
        
        return label
    }()
        
    internal lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "입력해 주세요."
        
        return textField
    }()
    
    private lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.text = "나이 입력"
        label.font = UIFont.customFont(size: 14, style: .Medium)
        
        return label
    }()
    
    internal lazy var startDateTextField: UITextField = {
        let textField = TextFieldWithDatePicker(frame: .zero, type: .dateWithCreateGather)
        textField.textColor = .white
        textField.backgroundColor = .Togaether.mainGreen
        textField.layer.cornerRadius = 15
        
        return textField
    }()
        
    internal lazy var ageTextField: UITextField = {
        let textField = TextFieldWithDatePicker(frame: .zero, type: .dateWithAddPet)
        textField.placeholder = "생일 입력"
        textField.textColor = .Togaether.primaryLabel
        textField.textAlignment = .left
        
        return textField
    }()
    
    private lazy var petSizeLabel: UILabel = {
        let label = UILabel()
        label.text = "반려견 크기"
        label.font = UIFont.customFont(size: 14, style: .Medium)
        
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
    
    private lazy var searchBreedLabel: UILabel = {
        let label = UILabel()
        label.text = "견종 검색"
        label.font = UIFont.customFont(size: 14, style: .Medium)
        
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
    
    internal lazy var breedLabel: UILabel = {
        let label = PaddingLabel(padding: UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0))
        label.backgroundColor = UIColor.Togaether.divider
        label.font = UIFont.customFont(size: 14, style: .Medium)
        label.textColor = UIColor.Togaether.secondaryLabel
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 15
    
        return label
    }()
    
    private lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.text = "성별 선택"
        label.font = UIFont.customFont(size: 14, style: .Medium)
        
        return label
    }()
    
    internal lazy var manButton: BorderButton = {
        let button = BorderButton()
        button.setTitle("남자입니다!", for: .normal)
        button.titleLabel?.font = UIFont.customFont(size: 16, style: .Medium)
        button.isSelected = false
        
        return button
    }()
    
    internal lazy var womanButton: BorderButton = {
        let button = BorderButton()
        button.setTitle("여자입니다!", for: .normal)
        button.titleLabel?.font = UIFont.customFont(size: 16, style: .Medium)
        button.isSelected = false
        
        return button
    }()
    
    private lazy var sexStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [manButton, womanButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        return stackView
    }()
    
    private let neutralizationLabel: UILabel = {
        let label = UILabel()
        label.text = "중성화 여부"
        label.font = UIFont.customFont(size: 14, style: .Medium)
        
        return label
    }()
    
    internal lazy var sexlessButton: BorderButton = {
        let button = BorderButton()
        button.setTitle("중성화 완료", for: .normal)
        button.titleLabel?.font = UIFont.customFont(size: 16, style: .Medium)
        button.isSelected = false
        
        return button
    }()
    
    internal lazy var genderedButton: BorderButton = {
        let button = BorderButton()
        button.setTitle("중성화 미완료", for: .normal)
        button.titleLabel?.font = UIFont.customFont(size: 16, style: .Medium)
        button.isSelected = false

        return button
    }()
    
    private lazy var neutralizationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sexlessButton, genderedButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        return stackView
    }()
    
    private let activityLabel: UILabel = {
        let label = UILabel()
        label.text = "반려견 활동 성향"
        label.font = UIFont.customFont(size: 14, style: .Medium)
        
        return label
    }()
    
    internal lazy var activeButton: BorderButton = {
        let button = BorderButton()
        button.setTitle("활발", for: .normal)
        button.titleLabel?.font = UIFont.customFont(size: 16, style: .Medium)
        button.isSelected = false

        return button
    }()
    
    internal lazy var docileButton: BorderButton = {
        let button = BorderButton()
        button.setTitle("온순", for: .normal)
        button.titleLabel?.font = UIFont.customFont(size: 16, style: .Medium)
        button.isSelected = false

        return button
    }()
    
    private lazy var activityStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [activeButton, docileButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        return stackView
    }()
    
    private let relationshipLabel: UILabel = {
        let label = UILabel()
        label.text = "반려견 관계 성향"
        label.font = UIFont.customFont(size: 14, style: .Medium)
        
        return label
    }()
    
    internal lazy var sociableButton: BorderButton = {
        let button = BorderButton()
        button.setTitle("사교적", for: .normal)
        button.titleLabel?.font = UIFont.customFont(size: 16, style: .Medium)
        button.isSelected = false

        return button
    }()
    
    internal lazy var independentButton: BorderButton = {
        let button = BorderButton()
        button.setTitle("독립적", for: .normal)
        button.titleLabel?.font = UIFont.customFont(size: 16, style: .Medium)
        button.isSelected = false

        return button
    }()
    
    private lazy var relationshipStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sociableButton, independentButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        return stackView
    }()
    
    private let adaptabilityLabel: UILabel = {
        let label = UILabel()
        label.text = "반려견 적응 성향"
        label.font = UIFont.customFont(size: 14, style: .Medium)
        
        return label
    }()
    
    internal lazy var adaptableButton: BorderButton = {
        let button = BorderButton()
        button.setTitle("능동적", for: .normal)
        button.titleLabel?.font = UIFont.customFont(size: 16, style: .Medium)
        button.isSelected = false

        return button
    }()
    
    internal lazy var inadaptableButton: BorderButton = {
        let button = BorderButton()
        button.setTitle("신중함", for: .normal)
        button.titleLabel?.font = UIFont.customFont(size: 16, style: .Medium)
        button.isSelected = false

        return button
    }()
    
    private lazy var adaptabilityStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [adaptableButton, inadaptableButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        return stackView
    }()
    
    private let addButtonDivider = Divider()
    
    internal let addButton: EnableButton = {
        let button = EnableButton()
        button.setTitle("반려견 등록하기", for: .normal)
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
        addSubview(guidanceLabel)
        addSubview(profileImageButton)
        addSubview(nameLabel)
        addSubview(nameTextField)
        addSubview(ageLabel)
        addSubview(ageTextField)
        addSubview(petSizeLabel)
        addSubview(petSizeStackView)
        addSubview(searchBreedLabel)
        addSubview(searchBreedBar)
        addSubview(breedLabel)
        addSubview(genderLabel)
        addSubview(sexStackView)
        addSubview(neutralizationLabel)
        addSubview(neutralizationStackView)
        addSubview(activityLabel)
        addSubview(activityStackView)
        addSubview(relationshipLabel)
        addSubview(relationshipStackView)
        addSubview(adaptabilityLabel)
        addSubview(adaptabilityStackView)
        addSubview(addButtonDivider)
        addSubview(addButton)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            guidanceLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            guidanceLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            guidanceLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            profileImageButton.topAnchor.constraint(equalTo: guidanceLabel.bottomAnchor, constant: 44),
            profileImageButton.widthAnchor.constraint(equalToConstant: 120),
            profileImageButton.heightAnchor.constraint(equalToConstant: 120),
            profileImageButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),

            nameLabel.topAnchor.constraint(equalTo: profileImageButton.bottomAnchor, constant: 44),
            nameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 26),
            
            ageLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 44),
            ageLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            ageTextField.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 20),
            ageTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            ageTextField.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            petSizeLabel.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 44),
            petSizeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            petSizeStackView.topAnchor.constraint(equalTo: petSizeLabel.bottomAnchor, constant: 20),
            petSizeStackView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            petSizeStackView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            petSizeStackView.heightAnchor.constraint(equalToConstant: 128),
            
            searchBreedLabel.topAnchor.constraint(equalTo: petSizeStackView.bottomAnchor, constant: 44),
            searchBreedLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            searchBreedBar.topAnchor.constraint(equalTo: searchBreedLabel.bottomAnchor, constant: 10),
            searchBreedBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            searchBreedBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),

            breedLabel.topAnchor.constraint(equalTo: searchBreedBar.bottomAnchor, constant: 10),
            breedLabel.leadingAnchor.constraint(equalTo: searchBreedBar.leadingAnchor, constant: 10),
            
            genderLabel.topAnchor.constraint(equalTo: breedLabel.bottomAnchor, constant: 44),
            genderLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            sexStackView.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 20),
            sexStackView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            sexStackView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            sexStackView.heightAnchor.constraint(equalToConstant: 44),
            
            neutralizationLabel.topAnchor.constraint(equalTo: sexStackView.bottomAnchor, constant: 44),
            neutralizationLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            neutralizationStackView.topAnchor.constraint(equalTo: neutralizationLabel.bottomAnchor, constant: 20),
            neutralizationStackView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            neutralizationStackView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            neutralizationStackView.heightAnchor.constraint(equalToConstant: 44),

            
            activityLabel.topAnchor.constraint(equalTo: neutralizationStackView.bottomAnchor, constant: 44),
            activityLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            activityStackView.topAnchor.constraint(equalTo: activityLabel.bottomAnchor, constant: 20),
            activityStackView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            activityStackView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            activityStackView.heightAnchor.constraint(equalToConstant: 44),

            relationshipLabel.topAnchor.constraint(equalTo: activityStackView.bottomAnchor, constant: 44),
            relationshipLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            relationshipStackView.topAnchor.constraint(equalTo: relationshipLabel.bottomAnchor, constant: 20),
            relationshipStackView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            relationshipStackView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            relationshipStackView.heightAnchor.constraint(equalToConstant: 44),

            adaptabilityLabel.topAnchor.constraint(equalTo: relationshipStackView.bottomAnchor, constant: 44),
            adaptabilityLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            adaptabilityStackView.topAnchor.constraint(equalTo: adaptabilityLabel.bottomAnchor, constant: 20),
            adaptabilityStackView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            adaptabilityStackView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            adaptabilityStackView.heightAnchor.constraint(equalToConstant: 44),

            addButtonDivider.topAnchor.constraint(equalTo: adaptabilityStackView.bottomAnchor, constant: 90),
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
