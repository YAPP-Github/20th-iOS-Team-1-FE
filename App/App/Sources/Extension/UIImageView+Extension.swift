//
//  UIImageView+Extension.swift
//  App
//
//  Created by 김나희 on 7/3/22.
//

import UIKit

extension UIImageView {
    func imageWithURL(_ urlString: String){
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        self?.clipsToBounds = true
                        self?.layer.cornerRadius = 60
                        self?.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
}
