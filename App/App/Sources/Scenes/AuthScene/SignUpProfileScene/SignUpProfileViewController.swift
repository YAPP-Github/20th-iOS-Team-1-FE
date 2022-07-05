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
  //  private let contentView = UIView()
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.keyboardDismissMode = .onDrag
        
        return scrollView
    }()
    
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
    
    private var profileImageButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.Togaether.cameraCircleFill, for: .normal)
        button.backgroundColor = .Togaether.divider
        button.layer.cornerRadius = button.frame.height / 2
        button.layer.masksToBounds = true
        button.imageView?.layer.cornerRadius = button.frame.width / 2
        button.imageView?.layer.masksToBounds = true
        button.clipsToBounds = true
        button.imageView?.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFit
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
        view.addSubview(scrollView)
      //  scrollView.addSubview(contentView)
        
        scrollView.addSubview(guidanceLabel)
        
        scrollView.addSubview(profileImageButton)
        
        scrollView.addSubview(nickNameLabel)
        
        scrollView.addSubview(nicknameTextField)
        scrollView.addSubview(duplicateCheckButton)
        scrollView.addSubview(deleteButton)
        
        scrollView.addSubview(nicknameContourView)
        
        view.addSubview(nextButtonContourView)
        view.addSubview(nextButton)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = scrollView.subviews.reduce(0) { $0 + $1.frame.height }
        
        scrollView.contentSize.height = height
    }
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -4),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            
            nextButtonContourView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            nextButtonContourView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            nextButtonContourView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -14),
            nextButtonContourView.heightAnchor.constraint(equalToConstant: 1),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: nextButtonContourView.topAnchor, constant: -14),

            guidanceLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 96),
            guidanceLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            guidanceLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            
            profileImageButton.topAnchor.constraint(equalTo: guidanceLabel.bottomAnchor, constant: 72),
            profileImageButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.5),
            profileImageButton.heightAnchor.constraint(equalTo: profileImageButton.widthAnchor),
            profileImageButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            nickNameLabel.topAnchor.constraint(equalTo: profileImageButton.bottomAnchor, constant: 57),
            nickNameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            
            nicknameTextField.topAnchor.constraint(equalTo: nickNameLabel.bottomAnchor, constant: 5),
            nicknameTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            
            duplicateCheckButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            duplicateCheckButton.widthAnchor.constraint(equalToConstant: 90),
            duplicateCheckButton.heightAnchor.constraint(equalToConstant: 36),
            duplicateCheckButton.centerYAnchor.constraint(equalTo: nicknameTextField.centerYAnchor),
            
            deleteButton.trailingAnchor.constraint(equalTo: duplicateCheckButton.leadingAnchor, constant: -8),
            deleteButton.centerYAnchor.constraint(equalTo: duplicateCheckButton.centerYAnchor),
  
            nicknameContourView.topAnchor.constraint(equalTo: deleteButton.bottomAnchor, constant: 10),
            nicknameContourView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            nicknameContourView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            nicknameContourView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .Togaether.background
        navigationController?.navigationBar.barTintColor = .Togaether.background
    }
    
    private func bindAction(with reactor: SignUpProfileReactor) {
        disposeBag.insert {
            profileImageButton.rx.tap.flatMapLatest { [weak self] (_) in
                return UIImagePickerController.rx.createWithParent(parent: self) { picker in
                    picker.sourceType = .photoLibrary
                    picker.allowsEditing = true
                }
                .flatMap { $0.rx.didFinishPickingMediaWithInfo }
                .take(1)
                }
                .map { $0[.originalImage] as? UIImage }
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
            
            RxKeyboard.instance.visibleHeight
                .skip(1)
                .drive(with: self,
                   onNext: { this, keyboardHeight in
                    this.scrollView.contentInset.bottom = keyboardHeight
                })
        }
    }
    
    private func bindState(with reactor: SignUpProfileReactor) {
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
                .map { $0.isNextButtonEnabled }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(with: self,
                   onNext: { this, isEnabled in
                    this.nextButton.isEnabled = isEnabled
                })
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
