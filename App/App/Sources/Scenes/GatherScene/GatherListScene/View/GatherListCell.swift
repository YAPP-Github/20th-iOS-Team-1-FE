//
//  GatherListCell.swift
//  App
//
//  Created by 김나희 on 6/9/22.
//

import UIKit

final class GatherListCell: UITableViewCell {
    private let tags: [String] = ["말티즈 외 2종", "소형견", "여성 Only", "4-5명", "코커스파이넬", "말티즈 외 6종"] // 임시 데이터

    private lazy var categoryLabel: PaddingLabel = {
        let label = PaddingLabel(padding: UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0))
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.backgroundColor = .Togaether.mainGreen
        label.text = "카테고리"
        label.textAlignment = .center
        label.font = .customFont(size: 12, style: .Medium)
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
        label.font = .customFont(size: 14, style: .Medium)
        label.countIcon(countString: label.text ?? "")

        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "모임 제목"
        label.textColor = .Togaether.primaryLabel
        label.font = .customFont(size: 18, style: .Bold)

        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "모임 장소 주소"
        label.textColor = .Togaether.secondaryLabel
        label.font = .customFont(size: 12, style: .Medium)

        return label
    }()
    
    private lazy var startDateLabel: UILabel = {
        let label = UILabel()
        label.text = "12월 31일(월) 10:10"
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
        label.text = "12월 31일(월) 10:10"
        label.textColor = .Togaether.mainGreen
        label.font = .customFont(size: 14, style: .Bold)

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
        addSubview(tagCollectionView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            categoryLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20.0),
            categoryLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            categoryLabel.heightAnchor.constraint(equalToConstant: 18.0),
            
            countLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 37.0),
            countLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            countLabel.widthAnchor.constraint(equalToConstant: 61.0),
            countLabel.heightAnchor.constraint(equalToConstant: 53.0),
            
            titleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 12.0),
            titleLabel.leadingAnchor.constraint(equalTo: categoryLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: countLabel.leadingAnchor, constant: -14.0),
            
            addressLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6.0),
            addressLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: countLabel.leadingAnchor, constant: -14.0),
            
            startDateLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 12.0),
            startDateLabel.leadingAnchor.constraint(equalTo: addressLabel.leadingAnchor),

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
            tagCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
            ])
    }
    
    private func configureUI() {
        backgroundColor = .Togaether.background
        separatorInset = UIEdgeInsets.zero
        selectionStyle = .none
    }
    
    internal func configureData(_ data: Content) {
        let size = data.eligiblePetSizeTypes.map { Array(arrayLiteral: $0.toKorean())[0] }.joined(separator: ",")
        let breed = data.eligibleBreeds ?? []
        let sex = data.eligibleSex.toKorean()
        let tag = breed + [size, sex]
        
        categoryLabel.text = data.category?.korean
        titleLabel.text = data.title
        addressLabel.text = data.meetingPlace
        startDateLabel.text = data.startDate?.toDateLabelText()
        endDateLabel.text = data.endDate?.toDateLabelText()
        countLabel.countIcon(countString: "\(data.participants)/\(data.maximumPeople)")
        tagCollectionView.reactor = TagCollectionViewReactor(state: tag)
    }
}


