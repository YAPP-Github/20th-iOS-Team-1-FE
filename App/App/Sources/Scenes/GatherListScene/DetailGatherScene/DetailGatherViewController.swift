//
//  DetailGatherViewController.swift
//  App
//
//  Created by Hani on 2022/07/04.
//

import UIKit

import ReactorKit
import RxSwift

final class DetailGatherViewController: BaseViewController {
    typealias Reactor = DetailGatherReactor
    
    private let contentView = UIView()
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.keyboardDismissMode = .onDrag
        
        return scrollView
    }()
    
    // 마끄 -----------------
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private lazy var gatherTitleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    // 마끄 -----------------
    private lazy var leaderNicknameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private lazy var leaderProfileImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private lazy var gatherDescriptionLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private lazy var eligiblePetSizeLabel: UILabel = {
        let label = UILabel()
        label.text = "가능 크기"
        return label
    }()
    
    private lazy var eligiblePetBreedLabel: UILabel = {
        let label = UILabel()
        label.text = "가능 견종"
        
        return label
    }()
    
    private lazy var eligibleSexLabel: UILabel = {
        let label = UILabel()
        label.text = "견주 성별"
        
        return label
    }()
    
    // 마끄 -----------------
    private lazy var gatherPlaceLabel: UILabel = {
        let label = UILabel()
        label.text = "모임 위치"
        
        return label
    }()
    
    private lazy var gatherAddressLabel: UILabel = {
        let label = UILabel()
        label.text = "상세 주소"
        return label
    }()
    
    private lazy var gatherAddressDescriptionLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    // 마끄 -----------------
    private lazy var participantLabel: UILabel = {
        let label = UILabel()
        label.text = "참여 인원"
        
        return label
    }()
    
    private lazy var participantDescriptionLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    
    
    // 마끄 -----------------
    private lazy var gatherCommentLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private lazy var emptyCommentLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton()
        
        return button
    }()

    // 마끄 -----------------
    private lazy var gatherButtonDivider = Divider()

    private lazy var gatherButton: EnableButton = {
        let button = EnableButton()
        button.isEnabled = false
        
        return button
    }()
    
    var disposeBag = DisposeBag()
    
    init(reactor: Reactor) {
        super.init(nibName: nil, bundle: nil)
        
        self.reactor = reactor
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
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        ])
    }
    
    private func configureUI() {
        
    }
    
    private func bindAction(with reactor: Reactor) {
        disposeBag.insert {
            
        }
    }
    
    private func bindState(with reactor: Reactor) {
        disposeBag.insert {
            
        }
    }
    
    func bind(reactor: Reactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
}
