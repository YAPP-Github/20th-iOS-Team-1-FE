//
//  CategorySelectView.swift
//  App
//
//  Created by 유한준 on 2022/07/10.
//

import UIKit

final class CategorySelectView: UIView {
    lazy var walkButton: CategorySelectButtonView = CategorySelectButtonView(category: .walk)
    
    lazy var playgroundButton: CategorySelectButtonView = CategorySelectButtonView(category: .playground)
    
    lazy var dogCafeButton: CategorySelectButtonView = CategorySelectButtonView(category: .dogCafe)
    
    lazy var dogRestaurantButton: CategorySelectButtonView = CategorySelectButtonView(category: .dogRestaurant)
    
    lazy var fairButton: CategorySelectButtonView = CategorySelectButtonView(category: .exhibition)
    
    lazy var etcButton: CategorySelectButtonView = CategorySelectButtonView(category: .etc)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubviews()
        configureLayout()
    }
    
    private func addSubviews() {
        self.addSubview(walkButton)
        self.addSubview(playgroundButton)
        self.addSubview(dogCafeButton)
        self.addSubview(dogRestaurantButton)
        self.addSubview(fairButton)
        self.addSubview(etcButton)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            walkButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            walkButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            walkButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.3),
            walkButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.45),

            dogCafeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            dogCafeButton.widthAnchor.constraint(equalTo: walkButton.widthAnchor),
            dogCafeButton.heightAnchor.constraint(equalTo: walkButton.heightAnchor),
            dogCafeButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),


            playgroundButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            playgroundButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            playgroundButton.widthAnchor.constraint(equalTo: walkButton.widthAnchor),
            playgroundButton.heightAnchor.constraint(equalTo: walkButton.heightAnchor),
        
            dogRestaurantButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            dogRestaurantButton.widthAnchor.constraint(equalTo: walkButton.widthAnchor),
            dogRestaurantButton.heightAnchor.constraint(equalTo: walkButton.heightAnchor),
            dogRestaurantButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            fairButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            fairButton.widthAnchor.constraint(equalTo: walkButton.widthAnchor),
            fairButton.heightAnchor.constraint(equalTo: walkButton.heightAnchor),
            fairButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            etcButton.widthAnchor.constraint(equalTo: walkButton.widthAnchor),
            etcButton.heightAnchor.constraint(equalTo: walkButton.heightAnchor),
            etcButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            etcButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
}

