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
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .Togaether.background
        
        return view
    }()
    
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

    private lazy var divider1 = Divider()
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
    
    private let leaderDivider = Divider()
    
    private lazy var eligiblePetSizeLabel: UILabel = {
        let label = UILabel()
        label.text = "가능 크기"
        return label
    }()
    
    private lazy var eligiblePetSizeView = TagCollectionView(reactor: TagCollectionViewReactor(state: []), frame: .zero)
    
    
    private lazy var eligiblePetBreedLabel: UILabel = {
        let label = UILabel()
        label.text = "가능 견종"
        
        return label
    }()
    
    private lazy var eligiblePetBreedView = TagCollectionView(reactor: TagCollectionViewReactor(state: []), frame: .zero)
    
    private lazy var eligibleSexLabel: UILabel = {
        let label = UILabel()
        label.text = "견주 성별"
        
        return label
    }()
    
    private lazy var eligibleSexView = TagCollectionView(reactor: TagCollectionViewReactor(state: []), frame: .zero)
    
    private let divider2 = Divider()
    
    private lazy var gatherPlaceLabel: UILabel = {
        let label = UILabel()
        label.text = "모임 위치"
        label.font = .customFont(size: 16, style: .Bold)
        return label
    }()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        
        mapView.isPitchEnabled = false
        mapView.isScrollEnabled = false
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
        label.text = "상세 주소"
        return label
    }()
    
    private let divider3 = Divider()
    
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
    
    private lazy var participantCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(ParticipantCollectionViewCell.self, forCellWithReuseIdentifier: ParticipantCollectionViewCell.identifier)
        collectionView.backgroundColor = .Togaether.background
        collectionView.contentInset = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        
        return collectionView
    }()
    
    private let divider4 = Divider()
    
    private lazy var commentTableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.alwaysBounceVertical = false
        tableView.register(CommentCell.self, forCellReuseIdentifier: CommentCell.identifier)
        tableView.backgroundColor = .Togaether.background
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
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
        button.layer.borderColor = UIColor.Togaether.mainGreen.cgColor
        button.setTitle("  댓글 달기  ", for: .normal)
        button.setTitleColor(UIColor.Togaether.mainGreen, for: .normal)
        //button.setImage(UIImage(systemName: "plus.bubble"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.titleLabel?.font = .customFont(size: 12)
        
        return button
    }()

    private let divider5 = Divider()
    private let gatherButton: EnableButton = {
        let button = EnableButton()
        button.isEnabled = false
        
        return button
    }()
    
    private let reportSubject = PublishSubject<Void>()
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
        
        contentView.addSubview(gatherCategoryLabel)
        contentView.addSubview(gatherTitleLabel)
        contentView.addSubview(gatherDayLabel)
        contentView.addSubview(divider1)
        
        contentView.addSubview(leaderProfileImageView)
        contentView.addSubview(leaderNicknameLabel)
        contentView.addSubview(gatherDescriptionLabel)
        contentView.addSubview(leaderDivider)
        contentView.addSubview(eligiblePetSizeLabel)
        contentView.addSubview(eligiblePetSizeView)
        contentView.addSubview(eligiblePetBreedLabel)
        contentView.addSubview(eligiblePetBreedView)
        contentView.addSubview(eligibleSexLabel)
        contentView.addSubview(eligibleSexView)
        contentView.addSubview(divider2)
        
        contentView.addSubview(gatherPlaceLabel)
        contentView.addSubview(mapView)
        contentView.addSubview(gatherAddressLabel)
        contentView.addSubview(gatherAddressDescriptionLabel)
        contentView.addSubview(divider3)
        
        contentView.addSubview(participantLabel)
        contentView.addSubview(participantDescriptionLabel)
        contentView.addSubview(participantCollectionView)
        contentView.addSubview(divider4)
        
        contentView.addSubview(gatherCommentLabel)
        contentView.addSubview(commentTableView)
        contentView.addSubview(addCommentButton)
        
        contentView.addSubview(divider5)
        contentView.addSubview(gatherButton)
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
            
            
            
            gatherCategoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            gatherCategoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            gatherTitleLabel.topAnchor.constraint(equalTo: gatherCategoryLabel.bottomAnchor, constant: 8),
            gatherTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            gatherDayLabel.topAnchor.constraint(equalTo: gatherTitleLabel.bottomAnchor, constant: 8),
            gatherDayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            divider1.topAnchor.constraint(equalTo: gatherDayLabel.bottomAnchor, constant: 30),
            divider1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            divider1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            divider1.heightAnchor.constraint(equalToConstant: 1),
            
            leaderProfileImageView.topAnchor.constraint(equalTo: divider1.bottomAnchor, constant: 20),
            leaderProfileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            leaderProfileImageView.widthAnchor.constraint(equalToConstant: 32),
            leaderProfileImageView.heightAnchor.constraint(equalToConstant: 32),
            leaderNicknameLabel.leadingAnchor.constraint(equalTo: leaderProfileImageView.trailingAnchor, constant: 8),
            leaderNicknameLabel.centerYAnchor.constraint(equalTo: leaderProfileImageView.centerYAnchor),
            gatherDescriptionLabel.topAnchor.constraint(equalTo: leaderProfileImageView.bottomAnchor, constant: 12),
            gatherDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            leaderDivider.topAnchor.constraint(equalTo: gatherDescriptionLabel.bottomAnchor, constant: 12),
            leaderDivider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            leaderDivider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            leaderDivider.heightAnchor.constraint(equalToConstant: 1),
            
            eligiblePetSizeLabel.topAnchor.constraint(equalTo: leaderDivider.bottomAnchor, constant: 20),
            eligiblePetSizeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            eligiblePetSizeView.leadingAnchor.constraint(equalTo: eligiblePetSizeLabel.trailingAnchor, constant: 12),
            eligiblePetSizeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            eligiblePetSizeView.centerYAnchor.constraint(equalTo: eligiblePetSizeLabel.centerYAnchor),
            eligiblePetSizeView.heightAnchor.constraint(equalToConstant: 30),
            
            eligiblePetBreedLabel.topAnchor.constraint(equalTo: eligiblePetSizeLabel.bottomAnchor, constant: 8),
            eligiblePetBreedLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            eligiblePetBreedView.leadingAnchor.constraint(equalTo: eligiblePetBreedLabel.trailingAnchor, constant: 12),
            eligiblePetBreedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            eligiblePetBreedView.centerYAnchor.constraint(equalTo: eligiblePetBreedLabel.centerYAnchor),
            eligiblePetBreedView.heightAnchor.constraint(equalToConstant: 30),
            
            eligibleSexLabel.topAnchor.constraint(equalTo: eligiblePetBreedLabel.bottomAnchor, constant: 8),
            eligibleSexLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            eligibleSexView.leadingAnchor.constraint(equalTo: eligibleSexLabel.trailingAnchor, constant: 12),
            eligibleSexView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            eligibleSexView.centerYAnchor.constraint(equalTo: eligibleSexLabel.centerYAnchor),
            eligibleSexView.heightAnchor.constraint(equalToConstant: 30),
            
            divider2.topAnchor.constraint(equalTo: eligibleSexLabel.bottomAnchor, constant: 30),
            divider2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            divider2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            divider2.heightAnchor.constraint(equalToConstant: 1),
            
            gatherPlaceLabel.topAnchor.constraint(equalTo: divider2.bottomAnchor, constant: 12),
            gatherPlaceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mapView.topAnchor.constraint(equalTo: gatherPlaceLabel.bottomAnchor, constant: 12),
            mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 200),
            gatherAddressLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 12),
            gatherAddressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            gatherAddressDescriptionLabel.topAnchor.constraint(equalTo: gatherAddressLabel.bottomAnchor, constant: 12),
            gatherAddressDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            divider3.topAnchor.constraint(equalTo: gatherAddressDescriptionLabel.bottomAnchor, constant: 30),
            divider3.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            divider3.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            divider3.heightAnchor.constraint(equalToConstant: 1),
          
            participantLabel.topAnchor.constraint(equalTo: divider3.bottomAnchor, constant: 12),
            participantLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            participantDescriptionLabel.leadingAnchor.constraint(equalTo: participantLabel.trailingAnchor, constant: 12),
            participantDescriptionLabel.centerYAnchor.constraint(equalTo: participantLabel.centerYAnchor),
            
            participantCollectionView.topAnchor.constraint(equalTo: participantLabel.bottomAnchor, constant: 12),
            participantCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            participantCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            participantCollectionView.heightAnchor.constraint(equalToConstant: 100),
            
            divider4.topAnchor.constraint(equalTo: participantCollectionView.bottomAnchor, constant: 30),
            divider4.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            divider4.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            divider4.heightAnchor.constraint(equalToConstant: 1),
            
            gatherCommentLabel.topAnchor.constraint(equalTo: divider4.bottomAnchor, constant: 12),
            gatherCommentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            commentTableView.topAnchor.constraint(equalTo: gatherCommentLabel.bottomAnchor, constant: 12),
            commentTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            commentTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            addCommentButton.topAnchor.constraint(equalTo: commentTableView.bottomAnchor, constant: 12),
            addCommentButton.centerXAnchor.constraint(equalTo: commentTableView.centerXAnchor),
            
            divider5.topAnchor.constraint(equalTo: addCommentButton.bottomAnchor, constant: 60),
            divider5.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            divider5.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            divider5.heightAnchor.constraint(equalToConstant: 1),
            
            gatherButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            gatherButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            gatherButton.topAnchor.constraint(equalTo: divider5.bottomAnchor, constant: 4),
            gatherButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            gatherButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func configureUI() {
        navigationItem.rightBarButtonItem = settingBarButton
        view.backgroundColor = .Togaether.background
    }
    
    private func bindAction(with reactor: Reactor) {
        disposeBag.insert {
            settingBarButton.rx.tap
                .observe(on: MainScheduler.instance)
                .subscribe(with: self,
                   onNext: { this, isEnabled in
                    this.presentActionSheet()
                })
            
            rx.viewWillAppear
                .map { _ in Reactor.Action.viewWillAppear }
                .bind(to: reactor.action)
            
            reportSubject
                .map { Reactor.Action.clubReportDidOccur }
                .bind(to: reactor.action)
            
            participantCollectionView.rx.itemSelected
                .map { Reactor.Action.participantDidTap($0.item) }
                .bind(to: reactor.action)
        }
    }
    
    private func bindState(with reactor: Reactor) {
        disposeBag.insert {
            reactor.state
                .map { $0.clubFindDetail }
                .observe(on: MainScheduler.instance)
                .bind(onNext: { [weak self] club in
                    guard let self = self,
                          let club = club else {
                        return
                    }
                    
                    self.eligiblePetSizeView.reactor = TagCollectionViewReactor(state: club.clubDetailInfo.eligiblePetSizeTypes)
                    self.eligibleSexView.reactor = TagCollectionViewReactor(state: [club.clubDetailInfo.eligibleSex])
                    self.eligiblePetBreedView.reactor = TagCollectionViewReactor(state: club.clubDetailInfo.eligibleBreeds)
                    
                    self.gatherCategoryLabel.text = "  " + club.clubDetailInfo.category + "  "
                    self.gatherTitleLabel.text = club.clubDetailInfo.title
                    self.gatherDayLabel.text = club.clubDetailInfo.startDate + club.clubDetailInfo.endDate
                    
                    self.leaderProfileImageView.imageWithURL(club.leaderInfo.imageURL)
                    self.leaderNicknameLabel.text = club.leaderInfo.nickname
                    self.gatherDescriptionLabel.text = club.clubDetailInfo.description
                    self.gatherAddressDescriptionLabel.text = club.clubDetailInfo.meetingPlace
                    self.participantDescriptionLabel.text = "\(club.clubDetailInfo.participants)/\(club.clubDetailInfo.maximumPeople)"
                    
                    let pLocation = CLLocationCoordinate2DMake(club.clubDetailInfo.latitude, club.clubDetailInfo.longitude)
                    let pSpanValue = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                    let pRegion = MKCoordinateRegion(center: pLocation, span: pSpanValue)
                    self.mapView.setRegion(pRegion, animated: false)
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = pLocation
                    self.mapView.addAnnotation(annotation)
                    
                    
                    self.commentTableView.heightAnchor.constraint(equalToConstant: CGFloat(club.commentInfos.count) * 120).isActive = true
                })
            
            reactor.state
                .map { $0.clubFindDetail?.accountInfos ?? [] }
                .observe(on: MainScheduler.instance)
                .bind(to: participantCollectionView.rx.items(cellIdentifier: ParticipantCollectionViewCell.identifier, cellType: ParticipantCollectionViewCell.self)) { index, data, cell in
                    cell.configure(imageURLString: data.imageURL, nickname: data.nickname)
                }
            
            reactor.state
                .map { $0.clubFindDetail?.commentInfos ?? [] }
                .observe(on: MainScheduler.instance)
                .bind(to: commentTableView.rx.items(cellIdentifier: CommentCell.identifier, cellType: CommentCell.self)) { index, data, cell in
                    cell.configure(imageURLString: data.imageURL,
                                   nickname: data.author,
                                   isLeader: data.leader,
                                   dog: data.breeds.first ?? "",
                                   date: data.updatedTime,
                                   comment: data.content)
                }
                

            reactor.state
                .map { $0.isClubReportSuccess }
                .distinctUntilChanged()
                .observe(on: MainScheduler.instance)
                .subscribe(with: self,
                   onNext: { this, _ in
                    this.presentAlert()
                })
        }
    }
    
    func bind(reactor: Reactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
    
    private func presentActionSheet() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let reportAction = UIAlertAction(title: "부적절한 모임 신고", style: .destructive, handler: { [weak self] _ in
            self?.reportSubject.onNext(())
        })
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alertController.addAction(reportAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func presentAlert() {
        let alertController = UIAlertController(title: "신고가 완료되었습니다.", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
