//
//  EmptyNoticeView.swift
//  App
//
//  Created by 김나희 on 7/12/22.
//

import UIKit

final class EmptyNoticeView: UIView {
    enum PageType {
        case pet
        case participatingGather
        case madeGather
        case cloedGather
        
        internal func labelText() -> String {
            switch self {
            case .pet:
                return "아직 반려견 등록을 하지 않으셨나요?\n 나의 반려견을 등록해보세요!"
            case .participatingGather:
                return "참여중인 모임이 없어요!\n 근처 모임을 참여해보세요."
            case .madeGather:
                return "내가 만든 모임이 없어요.\n 찾기 탭에서 플러스버튼을 눌러보세요!"
            case .cloedGather:
                return "참여 종료된 모임이 없어요!\n 근처 모임을 참여해보세요."
            }
        }
    }
    
    private lazy var imageView = UIImageView(image: UIImage.Togaether.emptyIcon)
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    
    init(frame: CGRect, type: PageType) {
        super.init(frame: frame)
        textLabel.text = type.labelText()
        addSubview(imageView)
        addSubview(textLabel)
        configureLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 144),
            imageView.heightAnchor.constraint(equalToConstant: 144),
            
            textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 17),
            textLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}
