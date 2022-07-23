//
//  UIButton+Extension.swift
//  App
//
//  Created by Hani on 2022/05/26.
//

import UIKit

extension UIButton {
    private func image(with color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context?.setFillColor(color.cgColor)
        context?.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }

    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        let backgroundImage = image(with: color)
        
        setBackgroundImage(backgroundImage, for: state)
    }
    
    func imageWithURL(_ urlString: String){
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        self?.setImage(UIImage(data: data), for: .normal)
                    }
                }
            }.resume()
        }
    }
}
