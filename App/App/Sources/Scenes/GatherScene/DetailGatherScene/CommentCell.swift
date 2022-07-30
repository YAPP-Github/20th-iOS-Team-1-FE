//
//  CommentCell.swift
//  App
//
//  Created by Hani on 2022/07/28.
//

import UIKit
import RxSwift

final class CommentCell: UITableViewCell {
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
    
    private let leaderLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.text = "  모임 방장  "
        label.tintColor = UIColor.Togaether.secondaryLabel
        label.layer.borderColor = UIColor.Togaether.secondaryLabel.cgColor
        label.font = .customFont(size: 14)
        
        return label
    }()
    
    private var dogLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(size: 12)
        label.textColor = .Togaether.secondaryLabel
        
        return label
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(size: 12)
        label.textColor = .Togaether.secondaryLabel
        
        return label
    }()
    
    private var commentLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(size: 16)
        label.textColor = .Togaether.primaryLabel
        
        return label
    }()
    
    private let reportButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.Togaether.setting, for: .normal)
        
        return button
    }()
    
    private var id: Int = 0
    private let disposeBag = DisposeBag()
    private let reportSubject = PublishSubject<Void>()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)   
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
        contentView.addSubview(leaderLabel)
        
        contentView.addSubview(dogLabel)
        contentView.addSubview(dateLabel)
        
        contentView.addSubview(commentLabel)
        
        contentView.addSubview(reportButton)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            profileImageButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            profileImageButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            profileImageButton.heightAnchor.constraint(equalToConstant: 50),
            profileImageButton.widthAnchor.constraint(equalToConstant: 50),
            
            nicknameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nicknameLabel.leadingAnchor.constraint(equalTo: profileImageButton.trailingAnchor, constant: 12),
            
            leaderLabel.centerYAnchor.constraint(equalTo: nicknameLabel.centerYAnchor),
            leaderLabel.leadingAnchor.constraint(equalTo: nicknameLabel.trailingAnchor, constant: 6),
            
            dogLabel.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: 8),
            dogLabel.leadingAnchor.constraint(equalTo: profileImageButton.trailingAnchor, constant: 12),
            
            dateLabel.centerYAnchor.constraint(equalTo: dogLabel.centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: dogLabel.trailingAnchor, constant: 6),
            
            commentLabel.topAnchor.constraint(equalTo: dogLabel.bottomAnchor, constant: 8),
            commentLabel.leadingAnchor.constraint(equalTo: profileImageButton.trailingAnchor, constant: 12),
            commentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            reportButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            reportButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
        ])
    }
    
    private func configureUI() {
        backgroundColor = .Togaether.background
    }
    
    private func bind() {
        disposeBag.insert {
            reportButton.rx.tap
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
                            guard let url = URL(string: APIConstants.BaseURL + APIConstants.reportComment + "/\(this.id)") else {
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
    }
    
    private func presentActionSheet() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let reportAction = UIAlertAction(title: "부적절한 댓글 신고", style: .destructive, handler: { [weak self] _ in
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
    
    func configure(id: Int, imageURLString: String, nickname: String, isLeader: Bool, dog: String, date: String, comment: String) {
        self.id = id
        profileImageButton.imageWithURL(imageURLString)
        nicknameLabel.text = nickname
        leaderLabel.isHidden = !isLeader
        dogLabel.text = dog
        dateLabel.text = date
        commentLabel.text = comment
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if parentResponder is UIViewController {
                return parentResponder as? UIViewController
            }
        }
        return nil
    }
}
