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
    
    init(coordinate: CLLocationCoordinate2D, gatherCategory: GatherCategory) {
        self.coordinate = coordinate
        self.gatherCategory = gatherCategory
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
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        guard let annotation = self.annotation as? Annotation
        else { return }
        self.canShowCallout = false
        switch annotation.gatherCategory {
        case .walk:
            self.image = UIImage.Togaether.defaultWalkMapViewAnnotaion
        case .dogCafe:
            self.image = UIImage.Togaether.defaultDogCafeMapviewAnnotation
        case .dogRestaurant:
            self.image = UIImage.Togaether.defaultDogRestaurantMapviewAnnotation
        case .exhibition:
            self.image = UIImage.Togaether.defaultExhibitionMapViewAnnotation
        case .playground:
            self.image = UIImage.Togaether.defaultPlaygroundMapViewAnnotation
        case .etc:
            self.image = UIImage.Togaether.defaultETCMapViewAnnotation
        }
        self.frame.size = CGSize(width: 28, height: 28)
    }
}
