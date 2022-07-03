//
//  RxImagePickerDelegateProxy.swift
//  App
//
//  Created by Hani on 2022/07/03.
//

import UIKit

import RxCocoa
import RxSwift

final class RxImagePickerDelegateProxy: RxNavigationControllerDelegateProxy, UIImagePickerControllerDelegate {
    public init(imagePicker: UIImagePickerController) {
        super.init(navigationController: imagePicker)
    }
}
