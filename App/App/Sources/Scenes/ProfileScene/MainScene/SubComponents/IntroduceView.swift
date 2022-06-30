//
//  IntroduceView.swift
//  App
//
//  Created by 김나희 on 6/25/22.
//

import UIKit

final class IntroduceView: UIView {
    private let tags: [String] = ["산책", "놀이터", "애견 카페", "애견 동반 식당", "박람회", "기타"] // 임시 데이터
    
    private lazy var introLabel: UILabel = {
        let label = UILabel()
        label.text = "우리 초코랑 같이 산책하실 분 구해요! 평행산책 같이 연습해요~"
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .customFont(size: 16, style: .Medium)
        
        return label
    }()
    
    
    private lazy var divisionView: UIView = {
        let view = UIView()
        view.backgroundColor = .Togaether.introduceViewDivider
        
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
        layout.minimumLineSpacing = 5
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .Togaether.introduceViewBackground
        collectionView.registerCell(type: TagCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
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
        addSubview(introLabel)
        addSubview(divisionView)
        addSubview(category)
        addSubview(categoryTagCollectionView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            introLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            introLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            introLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            divisionView.topAnchor.constraint(equalTo: introLabel.bottomAnchor, constant: 10),
            divisionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            divisionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            divisionView.heightAnchor.constraint(equalToConstant: 1),

            category.topAnchor.constraint(equalTo: divisionView.bottomAnchor, constant: 18),
            category.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            category.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -29),
            
            categoryTagCollectionView.topAnchor.constraint(equalTo: category.topAnchor),
            categoryTagCollectionView.leadingAnchor.constraint(equalTo: category.trailingAnchor, constant: 16),
            categoryTagCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            categoryTagCollectionView.bottomAnchor.constraint(equalTo: category.bottomAnchor, constant: 2)
            ])
    }
    
    private func configureUI() {
        backgroundColor = .Togaether.introduceViewBackground
    }
}


extension IntroduceView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueCell(withType: TagCollectionViewCell.self, for: indexPath) as? TagCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.changeTagStyle()
        cell.configureData(tags[indexPath.row])
        
        return cell
    }
    
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
