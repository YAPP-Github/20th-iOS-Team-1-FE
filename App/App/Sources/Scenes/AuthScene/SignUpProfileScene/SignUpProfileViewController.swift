//
//  SignUpProfileViewController.swift
//  App
//
//  Created by Hani on 2022/05/28.
//

import PhotosUI
import UIKit

import ReactorKit
import RxCocoa
import RxKeyboard

final class SignUpProfileViewController: BaseViewController {
    typealias Reactor = SignUpProfileReactor
    
    private let guidanceLabel: UILabel = {
        let text = "견주님의 프로필과\n닉네임을 등록해주세요."
        let boldFont = UIFont.boldSystemFont(ofSize: 32)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.font, value: boldFont, range: (text as NSString).range(of: "견주님의 프로필"))
        attributedText.addAttribute(.font, value: boldFont, range: (text as NSString).range(of: "닉네임"))
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32)
        label.textColor = .Togaether.primaryLabel
        label.attributedText = attributedText
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let profileImageButton: CircularButton = {
        let button = CircularButton()
        button.setBackgroundImage(.Togaether.userDefaultProfile, for: .normal)
        button.backgroundColor = .Togaether.background
        
        return button
    }()
    
    private let nickNameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임 입력"
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    private let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "한글/영어 10글자 이내"
        textField.keyboardType = .default
        
        return textField
    }()
    
    private let duplicateCheckButton: EnableButton = {
        let button = EnableButton(frame: CGRect(x: 0, y: 0, width: 90, height: 36))
        button.setTitle("중복확인", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    private let nicknameDivider = Divider()
    
    private let nicknameAlertLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Togaether.mainCoral
        label.font = .customFont(size: 12, style: .Medium)
        
        return label
    }()
    
    private let nextButtonDivider = Divider()

    private let nextButton: EnableButton = {
        let button = EnableButton()
        button.setTitle("다음", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        
        return button
    }()
    
    private var nicknameTextFieldConstraint: NSLayoutConstraint?
    
    var disposeBag = DisposeBag()
    
    init(reactor: SignUpProfileReactor) {
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nicknameTextField.resignFirstResponder()
    }
    
    private func addSubviews() {
        view.addSubview(guidanceLabel)
        view.addSubview(profileImageButton)
        
        view.addSubview(nickNameLabel)
        view.addSubview(nicknameTextField)
        view.addSubview(duplicateCheckButton)
        view.addSubview(nicknameDivider)
        view.addSubview(nicknameAlertLabel)
        
        view.addSubview(nextButtonDivider)
        view.addSubview(nextButton)
    }
    
    private func configureLayout() {
        let viewHeight = view.frame.height
        let viewWidth = view.frame.width
        NSLayoutConstraint.useAndActivateConstraints([
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -4),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            
            nextButtonDivider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            nextButtonDivider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            nextButtonDivider.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -4),
            nextButtonDivider.heightAnchor.constraint(equalToConstant: 1),
            
            guidanceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: viewHeight * 0.1),
            guidanceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            guidanceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            profileImageButton.topAnchor.constraint(equalTo: guidanceLabel.bottomAnchor, constant: viewHeight * 0.1),
            profileImageButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.4),
            profileImageButton.heightAnchor.constraint(equalTo: profileImageButton.widthAnchor),
            profileImageButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            nickNameLabel.topAnchor.constraint(equalTo: profileImageButton.bottomAnchor, constant: viewHeight * 0.1),
            nickNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            nicknameTextField.topAnchor.constraint(equalTo: nickNameLabel.bottomAnchor, constant: 5),
            nicknameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            duplicateCheckButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            duplicateCheckButton.widthAnchor.constraint(equalToConstant: 90),
            duplicateCheckButton.heightAnchor.constraint(equalToConstant: 36),
            duplicateCheckButton.centerYAnchor.constraint(equalTo: nicknameTextField.centerYAnchor),
  
            nicknameDivider.topAnchor.constraint(equalTo: duplicateCheckButton.bottomAnchor, constant: 4),
            nicknameDivider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nicknameDivider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            nicknameDivider.heightAnchor.constraint(equalToConstant: 1),
            
            nicknameAlertLabel.topAnchor.constraint(equalTo: nicknameDivider.bottomAnchor, constant: 10),
            nicknameAlertLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .Togaether.background
    }
    
    private func bindAction(with reactor: Reactor) {
        disposeBag.insert {
            profileImageButton.rx.tap.flatMapLatest { [weak self] (_) in
                return UIImagePickerController.rx.createWithParent(parent: self) { picker in
                    picker.sourceType = .photoLibrary
                    picker.allowsEditing = true
                }
                .flatMap { $0.rx.didFinishPickingMediaWithInfo }
                .take(1)
                }
                .map { $0[.editedImage] as? UIImage }
                .map { $0?.pngData() }
                .map { Reactor.Action.gallaryImageDidPick($0) }
                .bind(to: reactor.action)

            nicknameTextField.rx.text
                .orEmpty
                .distinctUntilChanged()
                .map { Reactor.Action.textFieldDidEndEditing($0) }
                .bind(to: reactor.action)
            
            duplicateCheckButton.rx.throttleTap
                .map { Reactor.Action.duplicateCheckButtonDidTap }
                .bind(to: reactor.action)
            
            nextButton.rx.throttleTap
                .map { Reactor.Action.nextButtonDidTap }
                .bind(to: reactor.action)
            
//            RxKeyboard.instance.visibleHeight
//                .skip(1)
//                .drive(with: self,
//                   onNext: { this, keyboardHeight in
//                    this.nicknameTextFieldConstraint?.constant = keyboardHeight + this.view.safeAreaInsets.bottom
//                    UIView.animate(withDuration: 0.3) {
//                        this.view.layoutIfNeeded()
//                    }
//                })
        }
    }
    
    private func bindState(with reactor: Reactor) {
        disposeBag.insert {
            reactor.state
                .map { $0.user.profileImageData }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: nil)
                .drive(with: self,
                   onNext: { this, imageData in
                    guard let imageData = imageData else {
                        return
                    }
                    
                    this.profileImageButton.setImage(UIImage(data: imageData), for: .normal)
                })
            
            reactor.state
                .map { $0.isNicknameValidationCheckDone }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(with: self,
                   onNext: { this, isEnabled in
                    this.duplicateCheckButton.isEnabled = isEnabled
                })
            
            reactor.state
                .map { $0.isNicknameDuplicateCheckDone }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(with: self,
                   onNext: { this, isEnabled in
                    this.nextButton.isEnabled = isEnabled
                    this.nicknameTextField.resignFirstResponder()
                })
            
            reactor.state
                .map { $0.alertLabel }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: "")
                .drive(with: self,
                   onNext: { this, text in
                    this.nicknameAlertLabel.text = text
                })
            
            reactor.state
                .map { $0.isNextButtonEnabled }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(with: self,
                   onNext: { this, isEnabled in
                    this.nextButton.isEnabled = isEnabled
                })
        }
    }
    
    func bind(reactor: Reactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
    
    private func presentAlert() {
        let alertController = UIAlertController(title: "설정", message: "앨범 접근이 허용되어 있지 않습니다.", preferredStyle: .alert)
    
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            guard let url = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        present(alertController, animated: true, completion: nil)
    }
}
