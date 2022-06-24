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

final class SignUpProfileViewController: BaseViewController {
    private var guidanceLabel: UILabel = {
        let text = "견주님의 프로필과\n닉네임을 등록해주세요."
        let boldFont = UIFont.boldSystemFont(ofSize: 32)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.font, value: boldFont, range: (text as NSString).range(of: "견주님의 프로필"))
        attributedText.addAttribute(.font, value: boldFont, range: (text as NSString).range(of: "닉네임"))
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32)
        label.textColor = .Togaether.primaryLabel
        label.attributedText = attributedText
        label.numberOfLines = 0
        
        return label
    }()
    
    private var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private var profileRegisterButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        button.setBackgroundImage(UIImage.Togaether.cameraCircleFill, for: .normal)
        
        return button
    }()
    
    private var nickNameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임 입력"
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    private var nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "한글/영어 10글자 이내"
        
        return textField
    }()
    
    private var duplicateCheckButton: EnableButton = {
        let button = EnableButton(frame: CGRect(x: 0, y: 0, width: 90, height: 36))
        button.setTitle("중복확인", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        
        return button
    }()
    
    private var deleteButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        button.setImage(UIImage.Togaether.xCircleFill, for: .normal)
        
        return button
    }()
    
    private lazy var nicknameContourView: UIView = {
        let contour = UIView()
        contour.backgroundColor = .Togaether.divider
        
        return contour
    }()
    
    private lazy var nextButtonContourView: UIView = {
        let contour = UIView()
        contour.backgroundColor = .Togaether.divider
        
        return contour
    }()

    private var nextButton: EnableButton = {
        let button = EnableButton()
        button.setTitle("다음", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        
        return button
    }()
    
    private lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.modalPresentationStyle = .fullScreen
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        picker.delegate = self
    
        return picker
    }()
    
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
        imagePicker.delegate = self
    }

    private func addSubviews() {
        view.addSubview(guidanceLabel)
        
        view.addSubview(profileImageView)
        view.addSubview(profileRegisterButton)
        
        view.addSubview(nickNameLabel)
        
        view.addSubview(nicknameTextField)
        view.addSubview(duplicateCheckButton)
        view.addSubview(deleteButton)
        
        view.addSubview(nicknameContourView)
        
        view.addSubview(nextButtonContourView)
        view.addSubview(nextButton)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            guidanceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 96),
            guidanceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            guidanceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            profileImageView.topAnchor.constraint(equalTo: guidanceLabel.bottomAnchor, constant: 72),
            profileImageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            profileRegisterButton.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
            profileRegisterButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            
            nickNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 57),
            nickNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            nicknameTextField.topAnchor.constraint(equalTo: nickNameLabel.bottomAnchor, constant: 5),
            nicknameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            duplicateCheckButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            duplicateCheckButton.centerYAnchor.constraint(equalTo: nicknameTextField.centerYAnchor),
            
            deleteButton.trailingAnchor.constraint(equalTo: duplicateCheckButton.leadingAnchor, constant: -8),
            deleteButton.centerYAnchor.constraint(equalTo: duplicateCheckButton.centerYAnchor),
  
            nicknameContourView.topAnchor.constraint(equalTo: deleteButton.bottomAnchor, constant: 10),
            nicknameContourView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nicknameContourView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            nicknameContourView.heightAnchor.constraint(equalToConstant: 1),
      
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -4),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            
            nextButtonContourView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            nextButtonContourView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            nextButtonContourView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -14),
            nextButtonContourView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .Togaether.background
    }
    
    private func bindAction(with reactor: SignUpProfileReactor) {
        disposeBag.insert {
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
            
            profileRegisterButton.rx.tap
                .asDriver()
                .drive(onNext: { [weak self] in
                    guard let self = self else {
                        return
                    }
                    
                    self.present(self.imagePicker, animated: true)
                })
        }
    }
    
    private func bindState(with reactor: SignUpProfileReactor) {
        disposeBag.insert {
            reactor.state
                .map { $0.isNicknameValidationCheckDone }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(duplicateCheckButton.rx.isEnabled)
            
            reactor.state
                .map { $0.isNicknameDuplicateCheckDone }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(nextButton.rx.isEnabled)
        }
    }
    
    func bind(reactor: SignUpProfileReactor) {
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

extension SignUpProfileViewController: UINavigationControllerDelegate { } // for ImagePicker, not implement

extension SignUpProfileViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profileImageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
}
