//
//  CategorySelectButtonView.swift
//  App
//
//  Created by 유한준 on 2022/07/10.
//

import UIKit

final class CategorySelectButtonView: UIView {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = self.category.korean
        label.font = label.font.withSize(16)
        
        return label
    }()
    
    private var category: GatherCategory
    internal var isSelected: Bool {
        didSet {
            switch isSelected {
            case true:
                switch self.category {
                case .walk:
                    imageView.image = .Togaether.walkButtonFill
                case .playground:
                    imageView.image = .Togaether.playgroundButtonFill
                case .dogCafe:
                    imageView.image = .Togaether.dofCafeButtonFill
                case .dogRestaurant:
                    imageView.image = .Togaether.dogRestaurantButtonFill
                case .exhibition:
                    imageView.image = .Togaether.fairButtonFill
                case .etc:
                    imageView.image = .Togaether.etcButtonFill
                }
                label.textColor = .Togaether.primaryLabel
            case false:
                switch self.category {
                case .walk:
                    imageView.image = .Togaether.walkButton
                case .playground:
                    imageView.image = .Togaether.playgroundButton
                case .dogCafe:
                    imageView.image = .Togaether.dofCafeButton
                case .dogRestaurant:
                    imageView.image = .Togaether.dogRestaurantButton
                case .exhibition:
                    imageView.image = .Togaether.fairButton
                case .etc:
                    imageView.image = .Togaether.etcButton
                }
                label.textColor = .Togaether.secondaryLabel
            }
        }
    }
    
    init(category: GatherCategory, isSelected: Bool) {
        self.category = category
        self.isSelected = isSelected
        super.init(frame: .zero)
        addSubviews()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
    }
    
    private func addSubviews() {
        self.addSubview(imageView)
        self.addSubview(label)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            imageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 44),
            imageView.widthAnchor.constraint(equalToConstant: 44),
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            
        ])
    }
    
    private func configureUI() {
        self.backgroundColor = UIColor.Togaether.divider
    }
    
}
