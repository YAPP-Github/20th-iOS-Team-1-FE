//
//  UIImagePickerViewController+Rx.swift
//  App
//
//  Created by Hani on 2022/07/03.
//

import UIKit

import RxCocoa
import RxSwift

extension Reactive where Base: UIImagePickerController {
    public var didCancel: Observable<()> {
        return delegate.methodInvoked(#selector(UIImagePickerControllerDelegate.imagePickerControllerDidCancel(_:))).map { (_) -> () in }
    }
    public var didFinishPickingMediaWithInfo: Observable<[UIImagePickerController.InfoKey: AnyObject]> {
        return delegate.methodInvoked(#selector(UIImagePickerControllerDelegate.imagePickerController(_:didFinishPickingMediaWithInfo:))).map { (a) in
            guard let result = a[1] as? Dictionary<UIImagePickerController.InfoKey, AnyObject> else {
                throw RxCocoaError.castingError(object: a[1], targetType: Dictionary<UIImagePickerController.InfoKey, AnyObject>.self)
            }
            
            return result
        }
    }
    
    static func createWithParent(parent: UIViewController?, animated: Bool = true, configureImagePicker: @escaping (UIImagePickerController) throws -> Void) -> Observable<UIImagePickerController> {
        return Observable.create { [weak parent] (observer) -> Disposable in
            let imagePicker = UIImagePickerController()
            let dismissDisposable = imagePicker.rx.didCancel.subscribe(onNext: { [weak imagePicker] _ in
                guard let imagePicker = imagePicker else {
                    return
                }
                
                dismissViewController(viewController: imagePicker, animated: animated)
            })
            
            do {
                try configureImagePicker(imagePicker)
            } catch let error {
                observer.onError(error)
                return Disposables.create()
            }
            
            guard let parent = parent else {
                observer.onCompleted()
                return Disposables.create()
            }
            parent.present(imagePicker, animated: animated, completion: nil)
            observer.on(.next(imagePicker))
            
            return Disposables.create(dismissDisposable, Disposables.create {
                dismissViewController(viewController: imagePicker, animated: animated)
            })
        

        }
    }
}

func dismissViewController(viewController: UIViewController, animated: Bool) {
    if viewController.isBeingPresented || viewController.isBeingDismissed {
        DispatchQueue.main.async {
            dismissViewController(viewController: viewController, animated: animated)
        }
    } else if viewController.presentingViewController != nil {
        viewController.dismiss(animated: animated, completion: nil)
    }
}
