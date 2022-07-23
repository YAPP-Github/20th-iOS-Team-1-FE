//
//  DetailGatherViewController.swift
//  App
//
//  Created by Hani on 2022/07/04.
//

import MapKit
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
        label.font = .customFont(size: 14)
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
        
    private var gatherDayLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(size: 16)
        label.textColor = .Togaether.mainGreen
        
        return label
    }()
    
    private lazy var gatherGuideStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        stackView.backgroundColor = .Togaether.background
        
        return stackView
    }()
    
    private let leaderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.backgroundColor = .Togaether.background
        
        return stackView
    }()

    private let leaderProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .Togaether.userDefaultProfile
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        
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
        stackView.backgroundColor = .Togaether.background
        
        return stackView
    }()
    
    private lazy var eligiblePetSizeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.backgroundColor = .Togaether.background
        
        return stackView
    }()
    
    private lazy var eligiblePetSizeLabel: UILabel = {
        let label = UILabel()
        label.text = "가능 크기"
        return label
    }()
    
    private lazy var eligiblePetSizeView = TagCollectionView(reactor: TagCollectionViewReactor(state: []), frame: .zero)
    
    private lazy var eligiblePetBreedStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.backgroundColor = .Togaether.background
        
        return stackView
    }()
    
    private lazy var eligiblePetBreedLabel: UILabel = {
        let label = UILabel()
        label.text = "가능 견종"
        
        return label
    }()
    
    private lazy var eligiblePetBreedView = TagCollectionView(reactor: TagCollectionViewReactor(state: []), frame: .zero)
    
    private lazy var eligibleSexStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.backgroundColor = .Togaether.background
        
        return stackView
    }()
    
    private lazy var eligibleSexLabel: UILabel = {
        let label = UILabel()
        label.text = "견주 성별"
        
        return label
    }()
    
    private lazy var eligibleSexView = TagCollectionView(reactor: TagCollectionViewReactor(state: []), frame: .zero)

    private lazy var gatherAddressStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 30, right: 20)
        stackView.backgroundColor = .Togaether.background
        
        return stackView
    }()
    
    private lazy var gatherPlaceLabel: UILabel = {
        let label = UILabel()
        label.text = "모임 위치"
        label.font = .customFont(size: 16, style: .Bold)
        return label
    }()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        
        mapView.isPitchEnabled = false
        mapView.setCameraZoomRange(
            MKMapView.CameraZoomRange(minCenterCoordinateDistance: 1000, maxCenterCoordinateDistance: 10000),
            animated: false
        )
        return mapView
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
    
    private lazy var participantStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 12, left: 20, bottom: 30, right: 20)
        stackView.backgroundColor = .Togaether.background
        
        return stackView
    }()
    
    private lazy var participantDescriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.backgroundColor = .Togaether.background
        
        return stackView
    }()
    
    private lazy var participantLabel: UILabel = {
        let label = UILabel()
        label.text = "참여 인원"
        label.font = .customFont(size: 16, style: .Bold)
        return label
    }()
    
    private lazy var participantDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(size: 16, style: .Bold)
        
        return label
    }()
    
    private lazy var participantCollectionView = ParticipantCollectionView(frame: .zero)
    
    private lazy var commentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 12, left: 20, bottom: 30, right: 20)
        stackView.backgroundColor = .Togaether.background
        
        return stackView
    }()
    
    private var commentCollectionView = UIView()
    
    private lazy var gatherCommentLabel: UILabel = {
        let label = UILabel()
        label.text = "모임 댓글"
        label.font = .customFont(size: 16, style: .Bold)
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
        gatherDescriptionStackView.addArrangedSubview(gatherDayLabel)
        
        detailGatherStackView.addArrangedSubview(gatherGuideStackView)
        gatherGuideStackView.addArrangedSubview(leaderStackView)
        leaderStackView.addArrangedSubview(leaderProfileImageView)
        leaderStackView.addArrangedSubview(leaderNicknameLabel)
        gatherGuideStackView.addArrangedSubview(gatherDescriptionLabel)
        
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
        
        detailGatherStackView.addArrangedSubview(gatherAddressStackView)
        gatherAddressStackView.addArrangedSubview(gatherPlaceLabel)
        gatherAddressStackView.addArrangedSubview(mapView)
        gatherAddressStackView.addArrangedSubview(gatherAddressLabel)
        gatherAddressStackView.addArrangedSubview(gatherAddressDescriptionLabel)
        
        detailGatherStackView.addArrangedSubview(participantStackView)
        participantStackView.addArrangedSubview(participantDescriptionStackView)
        participantDescriptionStackView.addArrangedSubview(participantLabel)
        participantDescriptionStackView.addArrangedSubview(participantDescriptionLabel)
        participantStackView.addArrangedSubview(participantCollectionView)
        
        detailGatherStackView.addArrangedSubview(commentStackView)
        commentStackView.addArrangedSubview(gatherCommentLabel)
        commentStackView.addArrangedSubview(commentCollectionView)
        commentStackView.addArrangedSubview(addCommentButton)
        
        
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
            detailGatherStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            leaderProfileImageView.widthAnchor.constraint(equalToConstant: 32),
            leaderProfileImageView.heightAnchor.constraint(equalToConstant: 32),
            participantCollectionView.heightAnchor.constraint(equalToConstant: 60)
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
            
            rx.viewWillAppear
                .map { _ in Reactor.Action.viewWillAppear }
                .bind(to: reactor.action)
            
            reportSubject
                .map { Reactor.Action.clubReportDidOccur }
                .bind(to: reactor.action)
        }
    }
    
    private func bindState(with reactor: Reactor) {
        disposeBag.insert {
            reactor.state
                .filter { $0.clubFindDetail != nil }
                .map { $0.clubFindDetail }
                .observe(on: MainScheduler.instance)
                .bind(onNext: { [weak self] club in
                    guard let self = self,
                          let club = club else {
                        return
                    }

                    self.gatherCategoryLabel.text = "  " + club.clubDetailInfo.category + "  "
                    self.gatherTitleLabel.text = club.clubDetailInfo.title
                    self.gatherDayLabel.text = club.clubDetailInfo.startDate + club.clubDetailInfo.endDate
                    
                    self.leaderProfileImageView.imageWithURL(club.leaderInfo.imageURL)
                    self.leaderNicknameLabel.text = club.leaderInfo.nickname
                    self.gatherDescriptionLabel.text = club.clubDetailInfo.description
                    
                    self.gatherAddressDescriptionLabel.text = club.clubDetailInfo.meetingPlace
                    self.participantDescriptionLabel.text = "\(club.clubDetailInfo.participants)/\(club.clubDetailInfo.maximumPeople)"
 
                    self.eligiblePetSizeView.reactor = TagCollectionViewReactor(state: club.clubDetailInfo.eligiblePetSizeTypes)
                    self.eligibleSexView.reactor = TagCollectionViewReactor(state: [club.clubDetailInfo.eligibleSex])
                    self.eligiblePetBreedView.reactor = TagCollectionViewReactor(state: club.clubDetailInfo.eligibleBreeds)
                })
            
            reactor.state
                .map { $0.clubFindDetail?.accountInfos ?? [] }
                .observe(on: MainScheduler.instance)
                .bind(to: participantCollectionView.rx.items(cellIdentifier: ParticipantCollectionViewCell.identifier, cellType: ParticipantCollectionViewCell.self)) { index, data, cell in
                    cell.configure(imageURLString: data.imageURL, nickname: data.nickname)
                }
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
