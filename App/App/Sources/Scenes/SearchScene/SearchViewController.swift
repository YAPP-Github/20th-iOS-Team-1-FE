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
        
        return mapView
    }()
    
    private lazy var gatherInformationBottomSheet: UIView = {
        let view = UIView()
        
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        view.backgroundColor = .systemBackground
        
        
        return view
    }()
    
    private lazy var gatherInformationBottomSheetHeightConstraint: NSLayoutConstraint = {
        let constraint = gatherInformationBottomSheet.heightAnchor.constraint(equalToConstant: 0)
        
        constraint.isActive = true
        
        return constraint
    }()
    
    private lazy var addButon: CircularButton =  {
        let button = CircularButton()
        button.setImage(UIImage.Togaether.plus, for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.Togaether.mainGreen
        
        return button
    }()
    
    private lazy var searchButton: CircularButton =  {
        let button = CircularButton()
        
        button.setImage(UIImage.Togaether.magnifyingglass, for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.Togaether.mainYellow
        
        return button
    }()
    
    private lazy var notificationBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: UIImage.Togaether.bell,
            style: .plain,
            target: SearchViewController.self,
            action: nil
        )
        
        barButtonItem.tintColor = .label
        
        return barButtonItem
    }()
    
    private lazy var AddCloseBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: UIImage.Togaether.xmark,
            style: .plain,
            target: SearchViewController.self,
            action: nil
        )
        
        barButtonItem.tintColor = .label
        
        return barButtonItem
    }()
    
    private lazy var currentLocationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.Togaether.scope, for: .normal)
        button.tintColor = UIColor.Togaether.mainGreen
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        return button
    }()
    
    private lazy var bottomSheetContentView: MapViewBottomSheetContentView = {
        let view = MapViewBottomSheetContentView(frame: .zero)
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.isHidden = true
        
        return view
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
        view.addSubview(gatherInformationBottomSheet)
        mapView.addSubview(searchButton)
        mapView.addSubview(addButon)
        gatherInformationBottomSheet.addSubview(bottomSheetContentView)
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
            //addButton
            addButon.heightAnchor.constraint(equalToConstant: 56),
            addButon.widthAnchor.constraint(equalToConstant: 56),
            addButon.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 22),
            addButon.trailingAnchor.constraint(equalTo: searchButton.trailingAnchor),
            //currentLocationButton
            currentLocationButton.widthAnchor.constraint(equalToConstant: 44),
            currentLocationButton.heightAnchor.constraint(equalToConstant: 44),
            currentLocationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            currentLocationButton.bottomAnchor.constraint(equalTo: gatherInformationBottomSheet.topAnchor, constant: -30),
            //bottomSheet
            gatherInformationBottomSheet.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            gatherInformationBottomSheet.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            //bottomSheetContentView
            bottomSheetContentView.topAnchor.constraint(equalTo: gatherInformationBottomSheet.topAnchor),
            bottomSheetContentView.leadingAnchor.constraint(equalTo: gatherInformationBottomSheet.leadingAnchor),
            bottomSheetContentView.trailingAnchor.constraint(equalTo: gatherInformationBottomSheet.trailingAnchor),
            bottomSheetContentView.bottomAnchor.constraint(equalTo: gatherInformationBottomSheet.bottomAnchor)
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = notificationBarButtonItem
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
            
            addButon.rx.throttleTap
                .bind { [unowned self] in
                    self.addButtonTouched()
                },
            
            AddCloseBarButtonItem.rx.tap
                .bind { [unowned self] in
                    
                },
            
            mapView.rx.didChangeVisibleRegion
                .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
                .map { [unowned self] in
                    Reactor.Action.mapViewVisibleRegionDidChanged(
                        self.mapView.topLeftCoordinate(),
                        self.mapView.bottomRightCoordinate()
                    )
                }
                .bind(to: reactor.action),
            
            mapView.rx.didChangeVisibleRegion
                .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
                .bind { [unowned self] in
                    convertToAddressWith(
                        coordinate: CLLocation(
                            latitude: self.mapView.centerCoordinate.latitude,
                            longitude: self.mapView.centerCoordinate.longitude
                        )
                    )
                }
            
        )
    }
    
    private func bindState(with reactor: SearchReactor) {
        disposeBag.insert(
            reactor.state
                .map { $0.annotations }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: [GatherConfigurationForAnnotation]() )
                .drive(onNext: { annotations in
                    for annotation in annotations {
                        let mapViewAnnotation = annotation.toAnnotation()
                        if self.mapView.view(for: mapViewAnnotation) == nil {
                            self.mapView.addAnnotation(mapViewAnnotation)
                        }
                    }
                }),
            
            reactor.state
                .map { $0.selectedGather }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: nil)
                .drive(onNext: { selectedGather in
                    self.bottomSheetContentView.configure(gatherConfiguration: selectedGather)
                })
        )
    }
    
    func bind(reactor: SearchReactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
    
    private func moveToCurrentLocation() {
        if let location = locationManager.location {
            mapView.setCenter(location.coordinate, animated: true)
        }
    }
    
    private func addButtonTouched() {
        navigationItem.title = "반려견 모임 생성"
        navigationItem.rightBarButtonItem = AddCloseBarButtonItem
    }
    
    func convertToAddressWith(coordinate: CLLocation) {
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        geocoder.reverseGeocodeLocation(coordinate, preferredLocale: locale, completionHandler: {(placemarks, error) in
            if let address: [CLPlacemark] = placemarks {
                var gatherAddress: [String] = []
                
                if let province = address.last?.administrativeArea {
                    gatherAddress.append(province)
                }
                
                if let locality = address.last?.locality {
                    gatherAddress.append(locality)
                }
                
                if let subLocality = address.last?.subLocality {
                    gatherAddress.append(subLocality)
                }
                
                if let street = address.last?.thoroughfare, street != gatherAddress.last {
                    gatherAddress.append(street)
                }
                
                if let subStreet = address.last?.subThoroughfare {
                    gatherAddress.append(subStreet)
                }
                
                // Change Label Text
            }
        })
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
                let annotation = view.annotation as? Annotation,
                let location = locationManager.location
        {
            view.select()
            reactor?.action
                .onNext(
                    .annotationViewDidSelect(
                        annotation.gather.id,
                        location
                    )
                )
            mapView.setCenter(annotation.coordinate, animated: true)
            UIView.animate(withDuration: 0.2, animations: {
                self.gatherInformationBottomSheetHeightConstraint.constant = 160
                self.bottomSheetContentView.isHidden = false
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        guard let view = view as? AnnotationView
        else { return }
        
        view.deselect()
        UIView.animate(withDuration: 0.2, animations: {
            self.gatherInformationBottomSheetHeightConstraint.constant = 0
            self.bottomSheetContentView.isHidden = true
            self.view.layoutIfNeeded()
        })
    }
}
