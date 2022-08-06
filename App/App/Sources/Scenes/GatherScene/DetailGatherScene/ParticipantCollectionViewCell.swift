//
//  ParticipantCollectionViewCell.swift
//  App
//
//  Created by Hani on 2022/07/23.
//

import UIKit

import RxSwift

final class ParticipantCollectionViewCell: UICollectionViewCell {
    private let profileImageButton: CircularButton = {
        let button = CircularButton()
        button.setBackgroundImage(.Togaether.userDefaultProfile, for: .normal)
        button.backgroundColor = .Togaether.background
        
        return button
    }()
    
    private var nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(size: 12)
        label.textColor = .Togaether.primaryLabel
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    private var id: Int = 0
    private let disposeBag = DisposeBag()
    private let reportSubject = PublishSubject<Void>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configureLayout()
        configureUI()
        bind()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(profileImageButton)
        contentView.addSubview(nicknameLabel)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            profileImageButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            profileImageButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            profileImageButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            profileImageButton.heightAnchor.constraint(equalToConstant: contentView.frame.width),
            
            nicknameLabel.centerXAnchor.constraint(equalTo: profileImageButton.centerXAnchor),
            nicknameLabel.topAnchor.constraint(equalTo: profileImageButton.bottomAnchor, constant: 8)
        ])
    }
    
    private func configureUI() {
        backgroundColor = .Togaether.background
    }
    
    private func bind() {
        disposeBag.insert {
            profileImageButton.rx.tap
                .asDriver(onErrorJustReturn: ())
                .drive(with: self,
                       onNext: { this, user in
                    this.presentActionSheet()
                })
                           
            reportSubject
                .subscribe(with: self,
                   onNext: { this, user in
                    let networkManager = NetworkManager.shared
                    let keychainProvider = KeychainProvider.shared
                    let keychainUseCase = KeychainUsecase(keychainProvider: keychainProvider, networkManager: networkManager)
                    
                    keychainUseCase.getAccessToken()
                        .subscribe(onSuccess: { token in
                            guard let url = URL(string: APIConstants.Report.account + "/\(this.id)") else {
                                return
                            }
                            
                            let accessToken = String(decoding: token, as: UTF8.self).makePrefixBearer()

                            var urlRequest = URLRequest(url: url)
                            urlRequest.httpMethod = HTTPMethod.post
                            urlRequest.addValue(accessToken, forHTTPHeaderField: "Authorization")
                            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
                            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
                            
                            let response: Single<Bool> = networkManager.requestDataTask(with: urlRequest)
                            
                            response
                                .observe(on: MainScheduler.instance)
                                .subscribe { result in
                                switch result {
                                case .success(_):
                                    this.presentAlert()
                                case .failure(let error):
                                    print("RESULT FAILURE: ", error.localizedDescription)
                                }
                            }.disposed(by: this.disposeBag)
                            
                        }).disposed(by: this.disposeBag)
                })
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageButton.setImage(.Togaether.userDefaultProfile, for: .normal)
        nicknameLabel.text = ""
    }
    
    private func presentActionSheet() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let reportAction = UIAlertAction(title: "부적절한 유저 신고", style: .destructive, handler: { [weak self] _ in
            self?.reportSubject.onNext(())
        })
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alertController.addAction(reportAction)
        alertController.addAction(cancelAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
   
    private func presentAlert() {
        let alertController = UIAlertController(title: "신고가 완료되었습니다.", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    func configure(imageURLString: String, nickname: String, id: Int) {
        profileImageButton.imageWithURL(imageURLString)
        nicknameLabel.text = nickname
        self.id = id
    }
}
