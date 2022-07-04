//
//  IntroduceView.swift
//  App
//
//  Created by 김나희 on 6/25/22.
//

import UIKit

import RxCocoa
import RxSwift

final class IntroduceView: UIView {
    private var tags = [String]()
    
    private lazy var introduceLabel: UILabel = {
        let label = UILabel()
        label.text = "우리 초코랑 같이 산책하실 분 구해요! 평행산책 같이 연습해요~"
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .customFont(size: 16, style: .Medium)
        
        return label
    }()
    
    
    private lazy var divisionView: UIView = {
        let view = UIView()
        view.backgroundColor = .Togaether.divider
        
        return view
    }()
    
    private lazy var category: UILabel = {
        let label = UILabel()
        label.text = "관심 카테고리"
        label.font = .customFont(size: 14, style: .Medium)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var categoryTagCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .Togaether.background
        collectionView.registerCell(type: TagCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    var disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubviews()
        configureLayout()
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(introduceLabel)
        addSubview(divisionView)
        addSubview(category)
        addSubview(categoryTagCollectionView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            introduceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            introduceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            introduceLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -25),
            
            divisionView.topAnchor.constraint(equalTo: introduceLabel.bottomAnchor, constant: 10),
            divisionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            divisionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            divisionView.heightAnchor.constraint(equalToConstant: 1),

            category.topAnchor.constraint(equalTo: divisionView.bottomAnchor, constant: 18),
            category.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            category.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -29),
            
            categoryTagCollectionView.topAnchor.constraint(equalTo: category.topAnchor),
            categoryTagCollectionView.leadingAnchor.constraint(equalTo: category.trailingAnchor, constant: 16),
            categoryTagCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            categoryTagCollectionView.bottomAnchor.constraint(equalTo: category.bottomAnchor, constant: 2)
            ])
    }
    
    private func configureUI() {
        backgroundColor = .Togaether.background
    }
    
    internal func configureData(_ accountData: AccountInfo?) {
        guard let accountData = accountData else {
            return
        }
        
        tags = accountData.categories ?? []

        disposeBag.insert {
            Observable.of(accountData.Introduction)
                .asDriver(onErrorJustReturn: "")
                .drive(onNext: { data in
                    self.introduceLabel.text = data
                })
            
            Observable.of(tags)
                .asDriver(onErrorJustReturn: [])
                .drive(categoryTagCollectionView.rx.items) { collectionView, row, data in
                    let indexPath = IndexPath(row: row, section: 0)
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell else {
                        return UICollectionViewCell()
                    }
                    cell.changeTagStyle()
                    cell.configureData(data)
                    
                    return cell
                }
        }
    }
}


extension IntroduceView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let item = tags[safe: indexPath.row] else {
            return CGSize(width: 0, height: 0)
        }
        let itemSize = item.size(withAttributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)
        ])

        return CGSize(width: itemSize.width + 17, height: 19)
    }

}
