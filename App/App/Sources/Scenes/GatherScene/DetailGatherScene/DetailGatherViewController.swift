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
    
    private lazy var settingBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage.Togaether.setting
        
        return button
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.keyboardDismissMode = .onDrag
        
        return scrollView
    }()
    
    private let detailGatherStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.backgroundColor = .Togaether.divider
        
        return stackView
    }()
    
    private let gatherDescriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.backgroundColor = .Togaether.background
        stackView.distribution = .fillProportionally
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 40, left: 20, bottom: 30, right: 20)
        
        return stackView
    }()
    
    private lazy var gatherCategoryLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.font = .customFont(size: 10)
        label.backgroundColor = .Togaether.mainGreen
        
        return label
    }()
    
    private lazy var gatherTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(size: 20)
        label.textColor = .Togaether.primaryLabel
        label.numberOfLines = 0
        
        return label
    }()
    
    private var gatherTimeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
        
    private var gatherDayLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(size: 16)
        label.textColor = .Togaether.mainGreen
        
        return label
    }()
    
    private let gatherTimeDivider = Divider()
    
    private var gatherDurationLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private lazy var gatherGuideStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        return stackView
    }()
    
    private let leaderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        
        return stackView
    }()

    private lazy var leaderProfileImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private var leaderNicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(size: 16)
        label.textColor = .Togaether.primaryLabel
        
        return label
    }()
    
    private lazy var gatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(size: 16)
        label.textColor = .Togaether.primaryLabel
        
        return label
    }()
    
    private let gatherRequirementDivider = Divider()
    
    private lazy var gatherRequirementStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 12, left: 20, bottom: 30, right: 20)
        
        return stackView
    }()
    
    private lazy var eligiblePetSizeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    private lazy var eligiblePetSizeLabel: UILabel = {
        let label = UILabel()
        label.text = "가능 크기"
        return label
    }()
    
    private lazy var eligiblePetSizeView = UIView()
    
    private lazy var eligiblePetBreedStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    private lazy var eligiblePetBreedLabel: UILabel = {
        let label = UILabel()
        label.text = "가능 견종"
        
        return label
    }()
    
    private lazy var eligiblePetBreedView = UIView()
    
    private lazy var eligibleSexStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    private lazy var eligibleSexLabel: UILabel = {
        let label = UILabel()
        label.text = "견주 성별"
        
        return label
    }()
    
    private lazy var eligibleSexView = UIView()
    
    private lazy var gatherPlaceLabel: UILabel = {
        let label = UILabel()
        label.text = "모임 위치"
        label.font = .customFont(size: 16, style: .Bold)
        return label
    }()
    
    private lazy var mapView = UIView()
    
    private lazy var gatherAddressStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 30, right: 20)
        
        return stackView
    }()
    
    private lazy var gatherAddressLabel: UILabel = {
        let label = UILabel()
        label.text = "상세 주소"
        label.textColor = .Togaether.primaryLabel
        label.font = .customFont(size: 16)
        
        return label
    }()
    
    private lazy var gatherAddressDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Togaether.secondaryLabel
        label.font = .customFont(size: 14)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let gatherPlaceDivider = Divider()
    
    private lazy var participantLabel: UILabel = {
        let label = UILabel()
        label.text = "참여 인원"
        
        return label
    }()
    
    private lazy var participantDescriptionLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let gatherParticipantDivider = Divider()
    
    private lazy var gatherCommentLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let emptyCommentLabel: UILabel = {
        let label = UILabel()
        label.text = "아직 댓글이 없어요\n모임에 대한 댓글을 달아보세요."
        label.font = .customFont(size: 18)
        label.textColor = .Togaether.primaryLabel
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let addCommentButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.setTitle("댓글 달기", for: .normal)
        button.setTitleColor(UIColor.Togaether.mainGreen, for: .normal)
        button.setImage(UIImage(systemName: "plus.bubble"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.titleLabel?.font = .customFont(size: 14)
        
        return button
    }()

    private lazy var gatherButtonDivider = Divider()
    private let reportSubject = PublishSubject<Void>()
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
        contentView.addSubview(detailGatherStackView)
        
        detailGatherStackView.addArrangedSubview(gatherDescriptionStackView)
        gatherDescriptionStackView.addArrangedSubview(gatherCategoryLabel)
        gatherDescriptionStackView.addArrangedSubview(gatherTitleLabel)
        gatherDescriptionStackView.addArrangedSubview(gatherTimeStackView)
        gatherTimeStackView.addArrangedSubview(gatherDayLabel)
        gatherTimeStackView.addArrangedSubview(gatherTimeDivider)
        gatherTimeStackView.addArrangedSubview(gatherDurationLabel)
        
        detailGatherStackView.addArrangedSubview(gatherGuideStackView)
        gatherGuideStackView.addArrangedSubview(leaderStackView)
        leaderStackView.addArrangedSubview(leaderProfileImageView)
        leaderStackView.addArrangedSubview(leaderNicknameLabel)
        gatherGuideStackView.addArrangedSubview(gatherRequirementDivider)
        gatherGuideStackView.addArrangedSubview(gatherRequirementStackView)
        gatherRequirementStackView.addArrangedSubview(eligiblePetSizeStackView)
        eligiblePetSizeStackView.addArrangedSubview(eligiblePetSizeLabel)
        eligiblePetSizeStackView.addArrangedSubview(eligiblePetSizeView)
        gatherRequirementStackView.addArrangedSubview(eligiblePetBreedStackView)
        eligiblePetBreedStackView.addArrangedSubview(eligiblePetBreedLabel)
        eligiblePetBreedStackView.addArrangedSubview(eligiblePetBreedView)
        gatherRequirementStackView.addArrangedSubview(eligibleSexStackView)
        eligibleSexStackView.addArrangedSubview(eligibleSexLabel)
        eligibleSexStackView.addArrangedSubview(eligibleSexView)
                
        //
        
        detailGatherStackView.addArrangedSubview(gatherButtonDivider)
        detailGatherStackView.addArrangedSubview(gatherButton)
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
            
            detailGatherStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            detailGatherStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            detailGatherStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            detailGatherStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    private func configureUI() {
        
        navigationItem.rightBarButtonItem = settingBarButton
    }
    
    private func bindAction(with reactor: Reactor) {
        disposeBag.insert {
            settingBarButton.rx.tap
                .observe(on: MainScheduler.instance)
                .subscribe(with: self,
                   onNext: { this, isEnabled in
                    this.presentAlertSheet()
                })
            
            reportSubject
                .map { Reactor.Action.reportDidOccur }
                .bind(to: reactor.action)
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
    
    private func presentAlertSheet() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let reportAction = UIAlertAction(title: "부적절한 모임 신고", style: .destructive, handler: { [weak self] _ in
            self?.reportSubject.onNext(())
        })
        let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)

        alertController.addAction(reportAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
