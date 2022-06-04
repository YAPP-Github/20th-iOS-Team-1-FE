//
//  CircularButton.swift
//  App
//
//  Created by 유한준 on 2022/06/04.
//

import UIKit

final class CircularButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.makeCircle()
    }
}
