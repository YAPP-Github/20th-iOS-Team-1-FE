//
//  TagCollectionView.swift
//  App
//
//  Created by 김나희 on 7/5/22.
//

import UIKit

import ReactorKit
import RxCocoa
import RxSwift

final class TagCollectionView: UICollectionView, View {
    typealias Reactor = TagCollectionViewReactor
    var tags = [String]()
    
    var disposeBag = DisposeBag()
    
    init(reactor: TagCollectionViewReactor, frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.reactor = reactor
        
        register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        showsHorizontalScrollIndicator = false
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .Togaether.background
    }
    
    func bind(reactor: TagCollectionViewReactor) {
        disposeBag.insert {
            reactor.state
                .distinctUntilChanged()
                .do(onNext: { self.tags = $0 })
                .asDriver(onErrorJustReturn: [])
                .drive(self.rx.items) { collectionView, row, data in
                    let indexPath = IndexPath(row: row, section: 0)
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell else {
                        return UICollectionViewCell()
                    }
                    cell.configureData(data)
                    
                    return cell
                }
        }
    }
}

extension TagCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let item = tags[safe: indexPath.row] else {
            return CGSize(width: 0, height: 0)
        }
        let itemSize = item.size(withAttributes: [
            NSAttributedString.Key.font : UIFont.customFont(size: 12, style: .Bold)
        ])
        
        return CGSize(width: itemSize.width + 18, height: 18)
    }
}
