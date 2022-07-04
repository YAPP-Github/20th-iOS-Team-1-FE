//
//  DogTableViewCell.swift
//  App
//
//  Created by 김나희 on 6/27/22.
//

import UIKit

final class DogTableViewCell: UITableViewCell {
    private lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.image = .Togaether.petDefaultProfile
        view.layer.cornerRadius = 36
        
        return view
    }()
    
    private lazy var dogNameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = .customFont(size: 18, style: .Bold)
        label.textColor = .Togaether.primaryLabel
        
        return label
    }()
    
    private lazy var breedLabel: UILabel = {
        let label = UILabel()
        label.text = "골든리트리버"
        label.font = .customFont(size: 14, style: .Bold)
        label.textColor = .Togaether.primaryLabel
        
        return label
    }()
    
    private lazy var divisionView: UIView = {
        let view = UIView()
        view.backgroundColor = .Togaether.divider
        
        return view
    }()
    
    private lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.text = "4세"
        label.font = .customFont(size: 14, style: .Medium)
        label.textColor = .Togaether.primaryLabel
        
        return label
    }()
    
    private lazy var genderImageView: UIImageView = {
        let view = UIImageView()
        view.image = .Togaether.genderSignGirlPuppy
        
        return view
    }()
        
    private lazy var tagStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        
        return stackView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 20.0, left: 20.0, bottom: 0.0, right: 20.0))
        addSubviews()
        configureLayout()
        configureUI()
    }
    
    private func addSubviews() {
        addSubview(profileImageView)
        addSubview(dogNameLabel)
        addSubview(breedLabel)
        addSubview(divisionView)
        addSubview(ageLabel)
        addSubview(genderImageView)
        addSubview(tagStackView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            profileImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 38),
            profileImageView.widthAnchor.constraint(equalToConstant: 72),
            profileImageView.heightAnchor.constraint(equalToConstant: 72),
            
            dogNameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            dogNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            dogNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -43),
            
            breedLabel.topAnchor.constraint(equalTo: dogNameLabel.bottomAnchor),
            breedLabel.leadingAnchor.constraint(equalTo: dogNameLabel.leadingAnchor),
            
            divisionView.leadingAnchor.constraint(equalTo: breedLabel.trailingAnchor, constant: 10),
            divisionView.centerYAnchor.constraint(equalTo: breedLabel.centerYAnchor),
            divisionView.widthAnchor.constraint(equalToConstant: 1),
            divisionView.heightAnchor.constraint(equalToConstant: 12),
            
            ageLabel.topAnchor.constraint(equalTo: breedLabel.topAnchor),
            ageLabel.leadingAnchor.constraint(equalTo: divisionView.trailingAnchor, constant: 10),
            
            genderImageView.leadingAnchor.constraint(equalTo: ageLabel.trailingAnchor, constant: 10),
            genderImageView.centerYAnchor.constraint(equalTo: breedLabel.centerYAnchor),
            genderImageView.widthAnchor.constraint(equalToConstant: 20),
            genderImageView.heightAnchor.constraint(equalToConstant: 20),
            
            tagStackView.topAnchor.constraint(equalTo: divisionView.bottomAnchor, constant: 12),
            tagStackView.leadingAnchor.constraint(equalTo: dogNameLabel.leadingAnchor),
            tagStackView.heightAnchor.constraint(equalToConstant: 18)
            ])
    }
    
    func configureUI() {
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.Togaether.divider.cgColor
        contentView.layer.cornerRadius = 10
    }
    
    internal func configureData(_ petData: PetInfo?) {
        guard let data = petData else {
            return
        }
        
        profileImageView.imageWithURL(data.imageURL ?? "")
        dogNameLabel.text = data.nickName
        breedLabel.text = data.breed
        ageLabel.text = data.age
        data.tags?.forEach({ tag in
            let label = PaddingLabel().tagLabel(tag)
            label.sizeToFit()
            tagStackView.addArrangedSubview(label)
        })
    }

}
