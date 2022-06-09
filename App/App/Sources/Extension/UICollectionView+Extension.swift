//
//  UICollectionView+Extension.swift
//  App
//
//  Created by 김나희 on 6/9/22.
//

import UIKit

extension UICollectionView {
    func registerCell(type: UICollectionViewCell.Type, identifier: String? = nil) {
        register(type, forCellWithReuseIdentifier: type.identifier)
    }
    
    func dequeueCell<T: UICollectionViewCell>(withType type: UICollectionViewCell.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath) as? T
    }
}
