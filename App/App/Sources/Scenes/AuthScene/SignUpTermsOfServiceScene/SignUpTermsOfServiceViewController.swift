//
//  SignUpTermsOfServiceViewController.swift
//  App
//
//  Created by Hani on 2022/07/01.
//

import UIKit

final class SignUpTermsOfServiceViewController: UIViewController {
    private var scrollView = UIScrollView()
    private var contentView = UIView()
    
    private lazy var guidanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = .Togaether.primaryLabel
        label.text = "투개더(Togaether)\n서비스 이용약관"
        label.numberOfLines = 0
        
        return label
    }()
    
    private var guideStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 12
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        
        return stackView
    }()
    
    private lazy var guideView1 = GuideView(title: "제1조 (목적)", guide: """
        이 약관은 투개더 운영진(이하 “제공자”)이 제공하는 '투개더(Togaether)' 서비스를 이용함에 있어 운영진과 회원 간의 권리, 의무 및 책임사항과 절차 등을 정하기 위해 만들어졌습니다.
    """)
    
    private lazy var guideView2 = GuideView(title: "제2조 (정의)", guide: """
    이 약관에서는 용어를 다음과 같이 정의하여 사용합니다.
    "서비스"란 회원의 단말기(모바일, 태블릿PC 등 각종 유/무선 장치를 포함)를 통하여 제공자가 제공하는 '투개더(Togaether)' 서비스 일체를 말합니다.
    "회원"이란 서비스에 접속하여 이 약관에 따라 제공자와 이용계약을 체결함으로써 서비스를 이용하는 고객을 말합니다.
    "닉네임"이란 회원의 식별과 서비스 제공을 위하여 회원이 정하고 제공자가 승인한 문자와 숫자의 조합입니다.
    "포인트"란 본 약관 제12조에 따라 회원이 일정한 행위를 마친 때에 시스템에 적립되는 서비스 상의 데이터입니다.
    "제휴 컨텐츠"란 제공자가 외부 업체와의 제휴를 통하여 회원에게 제공하는 유/무상의 컨텐츠를 말합니다.
    """)
    
    private lazy var guideView3 = GuideView(title: "제3조 (약관의 게시와 개정)", guide: """
    3
    """)
    private lazy var guideView4 = GuideView(title: "", guide: """
    4
    """)
    private lazy var guideView5 = GuideView(title: "", guide: """
    5
    """)
    private lazy var guideView6 = GuideView(title: "", guide: """
    6
    """)
    private lazy var guideView7 = GuideView(title: "", guide: """
    7
    """)
    private lazy var guideView8 = GuideView(title: "", guide: """
    8
    """)
    private lazy var guideView9 = GuideView(title: "", guide: """
    9
    """)
    private lazy var guideView10 = GuideView(title: "", guide: """
    10
    """)
    
    init() {
        super.init(nibName: nil, bundle: nil)
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
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(guidanceLabel)
        contentView.addSubview(guideStackView)
        
        guideStackView.addArrangedSubview(guideView1)
        guideStackView.addArrangedSubview(guideView2)
        guideStackView.addArrangedSubview(guideView3)
        guideStackView.addArrangedSubview(guideView4)
        guideStackView.addArrangedSubview(guideView5)
        guideStackView.addArrangedSubview(guideView6)
        guideStackView.addArrangedSubview(guideView7)
        guideStackView.addArrangedSubview(guideView8)
        guideStackView.addArrangedSubview(guideView9)
        guideStackView.addArrangedSubview(guideView10)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor),
            
            guidanceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            guidanceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            guidanceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            guideStackView.topAnchor.constraint(equalTo: guidanceLabel.bottomAnchor, constant: 24),
            guideStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            guideStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            guideStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    private func configureUI() { }
}
