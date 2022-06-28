//
//  MapViewAnnotation.swift
//  App
//
//  Created by 유한준 on 2022/06/27.
//

import UIKit
import MapKit

final class Annotation: NSObject, MKAnnotation {
    internal var coordinate: CLLocationCoordinate2D
    internal var gatherCategory: GatherCategory
    internal var isSelected: Bool
    
    init(coordinate: CLLocationCoordinate2D, gatherCategory: GatherCategory) {
        self.coordinate = coordinate
        self.gatherCategory = gatherCategory
        self.isSelected = false
    }
}

final class AnnotationView: MKAnnotationView {
    
    override var annotation: MKAnnotation? {
        didSet {
            configure()
        }
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func select() {
        guard let annotation = self.annotation as? Annotation
        else { return }
        
        annotation.isSelected = true
        configure()
    }
    
    internal func deselect() {
        guard let annotation = self.annotation as? Annotation
        else { return }
        
        annotation.isSelected = false
        configure()
    }
    
    private func configure() {
        guard let annotation = self.annotation as? Annotation
        else { return }
        self.canShowCallout = false
        switch annotation.gatherCategory {
        case .walk:
            self.image = annotation.isSelected ? UIImage.Togaether.focusWalkMapViewAnnotation: UIImage.Togaether.defaultWalkMapViewAnnotation
        case .dogCafe:
            self.image = annotation.isSelected ? UIImage.Togaether.focusDogCafeMapviewAnnotation: UIImage.Togaether.defaultDogCafeMapViewAnnotation
        case .dogRestaurant:
            self.image = annotation.isSelected ? UIImage.Togaether.focusDogRestaurantMapviewAnnotation: UIImage.Togaether.defaultDogRestaurantMapviewAnnotation
        case .exhibition:
            self.image = annotation.isSelected ? UIImage.Togaether.focusExhibitionMapViewAnnotation: UIImage.Togaether.defaultExhibitionMapViewAnnotation
        case .playground:
            self.image = annotation.isSelected ? UIImage.Togaether.focusPlaygroundMapViewAnnotation: UIImage.Togaether.defaultPlaygroundMapViewAnnotation
        case .etc:
            self.image = annotation.isSelected ? UIImage.Togaether.focusETCMapViewAnnotation: UIImage.Togaether.defaultETCMapViewAnnotation
        }
        self.frame.size = annotation.isSelected ? CGSize(width: 48, height: 54) : CGSize(width: 28, height: 28)
    }
}
