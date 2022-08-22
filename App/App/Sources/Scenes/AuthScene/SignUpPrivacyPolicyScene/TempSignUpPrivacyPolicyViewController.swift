//
//  TempSignUpPrivacyPolicyViewController.swift
//  App
//
//  Created by 김나희 on 8/9/22.
//

import UIKit

final class TempSignUpPrivacyPolicyViewController: UIViewController {
    private lazy var guidanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = .Togaether.primaryLabel
        label.text = "투개더(Togaether)\n개인정보취급방침"
        label.numberOfLines = 0
        
        return label
    }()
    
    
    private lazy var detailViewButton: UIButton = {
        let button = UIButton()
        button.setTitle("자세히 보기", for: .normal)
        button.setTitleColor(UIColor.Togaether.mainGreen, for: .normal)
        button.addTarget(self, action: #selector(showDetail), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
           super.viewDidLoad()
           addSubviews()
           configureLayout()
           configureUI()
       }

       private func addSubviews() {
           view.addSubview(guidanceLabel)
           view.addSubview(detailViewButton)
       }
       
       private func configureLayout() {
           NSLayoutConstraint.useAndActivateConstraints([
            guidanceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            guidanceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            guidanceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
           
            detailViewButton.topAnchor.constraint(equalTo: guidanceLabel.bottomAnchor, constant: 24),
            detailViewButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            detailViewButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
           ])
       }
       
       private func configureUI() {
           view.backgroundColor = .Togaether.background
       }
       
       @objc private func showDetail(_ sender: UIButton) {
           if let url = URL(string: "https://jazzy-monarch-2bc.notion.site/Togaether-27ae560dcd02481c93aa50315a31a0c9") {
               UIApplication.shared.open(url, options: [:])
           }
       }
}
