//
//  MapViewBottomSheetContentView.swift
//  App
//
//  Created by 유한준 on 2022/07/02.
//

import UIKit

class MapViewBottomSheetContentView: UIView {
    
    private lazy var categoryLabel: PaddingLabel = {
        let label = PaddingLabel(padding: UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0))
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.backgroundColor = .Togaether.mainGreen
        label.text = "카테고리"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        
        return label
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .Togaether.divider
        label.text = "00/00"
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textColor = .Togaether.primaryLabel
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "모임 제목"
        label.textColor = .Togaether.primaryLabel
        label.font = UIFont.boldSystemFont(ofSize: 16)

        return label
    }()
    
    private lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.text = "거리"
        label.textColor = .Togaether.secondaryLabel
        label.font = UIFont.systemFont(ofSize: 12)

        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "모임 장소 주소"
        label.textColor = .Togaether.secondaryLabel
        label.font = UIFont.systemFont(ofSize: 12)

        return label
    }()
    
    private lazy var startDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Togaether.mainGreen
        label.font = .customFont(size: 14, style: .Bold)

        return label
    }()
    
    private lazy var divisionView: UIView = {
        let view = UIView()
        view.backgroundColor = .Togaether.line
        
        return view
    }()
    
    private lazy var endDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Togaether.mainGreen
        label.font = .customFont(size: 14, style: .Bold)

        return label
    }()
    
    private lazy var hostProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 14
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var hostNickNameLabel: UILabel = {
        let label = UILabel()
        label.text = "호스트 닉네임"
        label.textColor = .Togaether.primaryLabel
        label.font = UIFont.systemFont(ofSize: 14)

        return label
    }()
    
    private lazy var tagStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.spacing = 4
        
        return stackView
    }()
    
    private lazy var dogTypeTagLabel: PaddingLabel = {
        let label = PaddingLabel(padding: UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0))
        label.backgroundColor = .white
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.Togaether.tagLine.cgColor
        label.font = .customFont(size: 12, style: .Regular)
        label.textColor = .Togaether.secondaryLabel
        label.textAlignment = .center
        label.text = "견종이름이어쩌구저쩌구열자가넘으면어쩌구저쩌구"
        label.lineBreakMode = .byTruncatingMiddle
        
        return label
    }()
    
    private lazy var dogSizeTagLabel: PaddingLabel = {
        let label = PaddingLabel(padding: UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0))
        label.backgroundColor = .white
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.Togaether.tagLine.cgColor
        label.font = .customFont(size: 12, style: .Regular)
        label.textColor = .Togaether.secondaryLabel
        label.textAlignment = .center
        label.text = "소,중,대형견"
        
        return label
    }()
    
    private lazy var sexTagLabel: PaddingLabel = {
        let label = PaddingLabel(padding: UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0))
        label.backgroundColor = .white
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.Togaether.tagLine.cgColor
        label.font = .customFont(size: 12, style: .Regular)
        label.textColor = .Togaether.secondaryLabel
        label.textAlignment = .center
        label.text = "여성 Only"
        
        return label
    }()

    private lazy var tagCollectionView: TagCollectionView = {
        let collectionView = TagCollectionView(reactor: TagCollectionViewReactor(state: []), frame: .zero)
        
        return collectionView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubviews()
        configureLayout()
        configureUI()
    }
    
    private func addSubviews() {
        addSubview(categoryLabel)
        addSubview(countLabel)
        addSubview(titleLabel)
        addSubview(addressLabel)
        addSubview(startDateLabel)
        addSubview(divisionView)
        addSubview(endDateLabel)
        addSubview(hostProfileImageView)
        addSubview(hostNickNameLabel)
        addSubview(distanceLabel)
        addSubview(tagCollectionView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            categoryLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 14.0),
            categoryLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            categoryLabel.heightAnchor.constraint(equalToConstant: 18.0),
            
            countLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 37.0),
            countLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            countLabel.widthAnchor.constraint(equalToConstant: 55.0),
            countLabel.heightAnchor.constraint(equalToConstant: 55.0),
            
            titleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 12.0),
            titleLabel.leadingAnchor.constraint(equalTo: categoryLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: countLabel.leadingAnchor, constant: -14.0),
            
            distanceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            distanceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            addressLabel.topAnchor.constraint(equalTo: distanceLabel.topAnchor),
            addressLabel.leadingAnchor.constraint(equalTo: distanceLabel.trailingAnchor, constant: 10),
            addressLabel.trailingAnchor.constraint(equalTo: countLabel.leadingAnchor, constant: -14.0),
            
            startDateLabel.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 12.0),
            startDateLabel.leadingAnchor.constraint(equalTo: distanceLabel.leadingAnchor),

            divisionView.leadingAnchor.constraint(equalTo: startDateLabel.trailingAnchor, constant: 8.0),
            divisionView.centerYAnchor.constraint(equalTo: startDateLabel.centerYAnchor),
            divisionView.widthAnchor.constraint(equalToConstant: 1.0),
            divisionView.heightAnchor.constraint(equalToConstant: 12.0),
            
            endDateLabel.topAnchor.constraint(equalTo: startDateLabel.topAnchor),
            endDateLabel.leadingAnchor.constraint(equalTo: divisionView.trailingAnchor, constant: 8.0),
            endDateLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8.0),
    
            tagCollectionView.topAnchor.constraint(equalTo: divisionView.bottomAnchor, constant: 16.0),
            tagCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tagCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            tagCollectionView.heightAnchor.constraint(equalToConstant: 30)
            ])
    }
    
    private func configureUI() {
        backgroundColor = .Togaether.background
    }
    
    internal func configure(gatherConfiguration: GatherConfigurationForSheet?) {
        if let data = gatherConfiguration {
            let size = data.eligiblePetSizeTypes.map { Array(arrayLiteral: $0.toKorean())[0] }.joined(separator: ",")
            let breed = data.eligibleBreeds
            let sex = data.eligibleSex.toKorean()
            let tag = (breed + [size, sex]).filter { $0 != "" }
            
            categoryLabel.text = data.category.korean
            distanceLabel.text = "거리 \(data.distance)m"
            titleLabel.text = data.title
            addressLabel.text = data.meetingPlace
            startDateLabel.text = data.startDate.toDateLabelText()
            endDateLabel.text = data.endDate.toDateLabelText()
            countLabel.countIcon(countString: "\(data.participants)/\(data.maximumPeople)")
            tagCollectionView.reactor = TagCollectionViewReactor(state: tag)
        }
    }
}

enum Weekday: Int {
    case sat, sun, mon, tue, wed, thu, fri
    
    internal var korean: String {
        switch self {
        case .sat:
            return "토"
        case .sun:
            return "일"
        case .mon:
            return "월"
        case .tue:
            return "화"
        case .wed:
            return "수"
        case .thu:
            return "목"
        case .fri:
            return "금"
        }
    }
}
