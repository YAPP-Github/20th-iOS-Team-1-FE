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
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "12월 31일(월)"
        label.textColor = .Togaether.mainGreen
        label.font = UIFont.boldSystemFont(ofSize: 14)

        return label
    }()
    
    private lazy var divisionView: UIView = {
        let view = UIView()
        view.backgroundColor = .Togaether.line
        
        return view
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "오후 10시 30분 - 12시"
        label.textColor = .Togaether.primaryLabel
        label.font = UIFont.systemFont(ofSize: 14)
        
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
        addSubview(dateLabel)
        addSubview(divisionView)
        addSubview(timeLabel)
        addSubview(hostProfileImageView)
        addSubview(hostNickNameLabel)
        addSubview(tagStackView)
        addSubview(distanceLabel)
        tagStackView.addSubview(dogTypeTagLabel)
        tagStackView.addSubview(dogSizeTagLabel)
        tagStackView.addSubview(sexTagLabel)
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
            distanceLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 60),
            
            
            addressLabel.topAnchor.constraint(equalTo: distanceLabel.topAnchor),
            addressLabel.leadingAnchor.constraint(equalTo: distanceLabel.trailingAnchor, constant: 10),
            addressLabel.trailingAnchor.constraint(equalTo: countLabel.leadingAnchor, constant: -14.0),
            
            dateLabel.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 12.0),
            dateLabel.leadingAnchor.constraint(equalTo: distanceLabel.leadingAnchor),

            divisionView.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 8.0),
            divisionView.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            divisionView.widthAnchor.constraint(equalToConstant: 1.0),
            divisionView.heightAnchor.constraint(equalToConstant: 12.0),
            
            timeLabel.topAnchor.constraint(equalTo: dateLabel.topAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: divisionView.trailingAnchor, constant: 8.0),
            timeLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8.0),
    
            tagStackView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 16.0),
            tagStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            tagStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            tagStackView.heightAnchor.constraint(equalToConstant: 18),
            
            dogTypeTagLabel.heightAnchor.constraint(equalTo: tagStackView.heightAnchor),
            dogTypeTagLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 150),
            
            dogSizeTagLabel.leadingAnchor.constraint(equalTo: dogTypeTagLabel.trailingAnchor, constant: 4),
            dogSizeTagLabel.heightAnchor.constraint(equalTo:tagStackView.heightAnchor),
            dogSizeTagLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 50),
            
            sexTagLabel.leadingAnchor.constraint(equalTo: dogSizeTagLabel.trailingAnchor, constant: 4),
            sexTagLabel.heightAnchor.constraint(equalTo: tagStackView.heightAnchor),
            sexTagLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 50)
            ])
    }
    
    private func configureUI() {
        backgroundColor = .Togaether.background
    }
    
    internal func configure(gatherConfiguration: GatherConfigurationForSheetResponseDTO?) {
//        titleLabel.text = gatherConfiguration?.title
//        categoryLabel.text = gatherConfiguration?.category.korean
//        distanceLabel.text = "거리 \(gatherConfiguration?.distance ?? 0)m"
//        addressLabel.text = gatherConfiguration?.meetingPlace
//        countLabel.text = "\(gatherConfiguration?.participants ?? 0)/\(gatherConfiguration?.maximumPeople ?? 0)"
//        if let startDate = gatherConfiguration?.startDate.toDate(),
//           let endDate = gatherConfiguration?.endDate.toDate(){
//            dateLabel.text = startDate.monthDayWeekDay()
//            timeLabel.text = startDate.hourMinute() + "-" + endDate.hourMinute()
//        }
//        dogTypeTagLabel.text = gatherConfiguration?.eligibleBreeds.count == 1 ? gatherConfiguration?.eligibleBreeds.first : "\(gatherConfiguration?.eligibleBreeds.first ?? "말티즈") 외 \((gatherConfiguration?.eligibleBreeds.count ?? 2) - 1)종"
//        dogSizeTagLabel.text = (gatherConfiguration?.eligiblePetSizeTypes.map{ String($0[String.Index(utf16Offset: 0, in: $0)]) }.joined(separator: ",") ?? "소") + "형견"
    }
}

extension String {
    func toDate() -> Date? { //"yyyy-MM-dd HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    func toString() -> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
           dateFormatter.timeZone = TimeZone(identifier: "UTC")
           return dateFormatter.string(from: self)
       }
    
    func monthDayWeekDay() -> String {
        "\(self.get(.month))월 \(self.get(.day))일(\(Weekday.init(rawValue: self.get(.weekday))?.korean ?? "월"))"
    }
    
    func hourMinute() -> String {
        let hour = self.get(.hour) < 10 ? "0\(self.get(.hour))" : "\(self.get(.hour))"
        let minute = self.get(.minute) < 10 ? "0\(self.get(.minute))" : "\(self.get(.minute))"
        
        return "\(hour):\(minute)"
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
