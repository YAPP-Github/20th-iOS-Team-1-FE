//
//  SearchViewController.swift
//  App
//
//  Created by 유한준 on 2022/06/04.
//

import UIKit
import MapKit

import ReactorKit
import RxCocoa
import AVFAudio

final class SearchViewController: BaseViewController {
    private let locationManager: CLLocationManager!
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        
        mapView.showsUserLocation = true
        mapView.showsCompass = false
        mapView.isPitchEnabled = false
        mapView.setCameraZoomRange(
            MKMapView.CameraZoomRange(minCenterCoordinateDistance: 1000, maxCenterCoordinateDistance: 10000),
            animated: false
        )
        mapView.delegate = self
        
        mapView.register(AnnotationView.self, forAnnotationViewWithReuseIdentifier: AnnotationView.identifier)
        
        mapView.addAnnotation(
            Annotation(
                coordinate: CLLocationCoordinate2D(
                    latitude: 37.29263305664062,
                    longitude: 127.11612977377284
                ),
                gatherCategory: .walk
            )
        )
        
        mapView.addAnnotation(
            Annotation(
                coordinate: CLLocationCoordinate2D(
                    latitude: 35.29263305664062,
                    longitude: 127.11612977377284
                ),
                gatherCategory: .playground
            )
        )
        
        mapView.addAnnotation(
            Annotation(
                coordinate: CLLocationCoordinate2D(
                    latitude: 38.29263305664062,
                    longitude: 127.11612977377284
                ),
                gatherCategory: .dogRestaurant
            )
        )
        
        mapView.addAnnotation(
            Annotation(
                coordinate: CLLocationCoordinate2D(
                    latitude: 37.29263305664062,
                    longitude: 128.11612977377284
                ),
                gatherCategory: .dogCafe
            )
        )
        
        mapView.addAnnotation(
            Annotation(
                coordinate: CLLocationCoordinate2D(
                    latitude: 35.29263305664062,
                    longitude: 126.11612977377284
                ),
                gatherCategory: .etc
            )
        )
        
        mapView.addAnnotation(
            Annotation(
                coordinate: CLLocationCoordinate2D(
                    latitude: 34.29263305664062,
                    longitude: 126.11612977377284
                ),
                gatherCategory: .exhibition
            )
        )
        
        return mapView
    }()
    
    private lazy var searchButton: CircularButton =  {
        let button = CircularButton()
        
        button.setImage(UIImage.Togaether.magnifyingglass, for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.Togaether.mainYellow
        
        return button
    }()
    
    private lazy var notificationItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: UIImage.Togaether.bell,
            style: .plain,
            target: SearchViewController.self,
            action: nil
        )
        
        barButtonItem.tintColor = .label
        
        return barButtonItem
    }()
    
    private lazy var currentLocationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.Togaether.target, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        return button
    }()
    
    var disposeBag = DisposeBag()
    
    init(reactor: SearchReactor, locationManager: CLLocationManager) {
        self.locationManager = locationManager
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureLayout()
        configureUI()
        configureLocationManager()
        
        if let reactor = reactor {
            bind(reactor: reactor)
        }
    }
    
    private func addSubviews() {
        view.addSubview(mapView)
        view.addSubview(currentLocationButton)
        mapView.addSubview(searchButton)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            //mapView
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            //searchButton
            searchButton.heightAnchor.constraint(equalToConstant: 56),
            searchButton.widthAnchor.constraint(equalToConstant: 56),
            searchButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 22),
            searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -22),
            //currentLocationButton
            currentLocationButton.widthAnchor.constraint(equalToConstant: 44),
            currentLocationButton.heightAnchor.constraint(equalToConstant: 44),
            currentLocationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            currentLocationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = notificationItem
    }
    
    func configureLocationManager() {
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        if let currentLocation = locationManager.location {
            mapView.centerCoordinate = currentLocation.coordinate
        } else {
            mapView.centerCoordinate = Coordinate.seoulCityHall.toCLLocationCoordinate2D()
        }
    }
    
    private func bindAction(with reactor: SearchReactor) {
        disposeBag.insert(
            currentLocationButton.rx.throttleTap
                .bind { [unowned self] in
                    self.moveToCurrentLocation()
                },
            
            mapView.rx.didChangeVisibleRegion
                .debounce(.milliseconds(250), scheduler: MainScheduler.instance)
                .map { [unowned self] in
                    Reactor.Action.mapViewVisibleRegionDidChanged(self.mapView.centerCoordinate)
                }
                .bind(to: reactor.action)
        )
    }
    
    private func bindState(with reactor: SearchReactor) {
        
    }
    
    func bind(reactor: SearchReactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
    
    private func moveToCurrentLocation() {
        if let location = locationManager.location {
            mapView.centerCoordinate = location.coordinate
        }
    }
}

extension SearchViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .restricted, .denied, .notDetermined:
            // TODO: Move To Setting
            break
        default:
            moveToCurrentLocation()
        }
    }
}

extension SearchViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Annotation
        else { return nil }
        
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationView.identifier, for: annotation) as? AnnotationView
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation is MKUserLocation {
            mapView.deselectAnnotation(view.annotation, animated: false)
        }
        else if let view = view as? AnnotationView,
                let annotation = view.annotation as? Annotation {
            annotation.isSelected = true
            view.configure()
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        guard let view = view as? AnnotationView,
              let annotation = view.annotation as? Annotation
        else { return }
        
        annotation.isSelected = false
        view.configure()
    }
}
