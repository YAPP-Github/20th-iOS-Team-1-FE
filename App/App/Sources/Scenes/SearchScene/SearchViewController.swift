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
        mapView.isZoomEnabled = true
        mapView.region.span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        mapView.delegate = self
        
        mapView.register(AnnotationView.self, forAnnotationViewWithReuseIdentifier: AnnotationView.identifier)
        
        return mapView
    }()
    
    private lazy var bottomSheet: UIView = {
        let view = UIView()
        
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        view.backgroundColor = .systemBackground
        
        
        return view
    }()
    
    private lazy var gatherInformationBottomSheetHeightConstraint: NSLayoutConstraint = {
        let constraint = bottomSheet.heightAnchor.constraint(equalToConstant: 0)
        
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
    
//    private lazy var searchButton: CircularButton =  {
//        let button = CircularButton()
//
//        button.setImage(UIImage.Togaether.magnifyingglass, for: .normal)
//        button.tintColor = .white
//        button.backgroundColor = UIColor.Togaether.mainYellow
//
//        return button
//    }()
    
    private lazy var addCloseBarButtonItem: UIBarButtonItem = {
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
    
    private lazy var setLocationBottomSheet: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.isHidden = true
        
        return view
    }()
    
    private lazy var setLocationDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "화면을 이동하여\n위치를 설정해주세요."
        label.font = label.font.withSize(28)
        label.numberOfLines = 0
        label.bold(targetString: "화면을 이동")
        
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(16)
        label.text = "주소"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var createGatherButton: EnableButton = {
        let button = EnableButton()
        button.layer.cornerRadius = 10
        button.setTitle("여기서 모임을 만들래요", for: .normal)
        button.setTitle("반려견을 등록해야 합니다.", for: .disabled)
        button.titleLabel?.font = button.titleLabel?.font.withSize(20)
        button.tintColor = UIColor.white
        button.isEnabled = false
        
        return button
    }()
    
    private lazy var selectLocationPinImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage.Togaether.selectedLocationMapViewAnnotation)
        imageView.isHidden = true
        return imageView
    }()
    
    private var isAddressConvertRequestPossible: Bool = true
    private var mapType: MapType = .search
    
    private enum MapType {
        case search
        case add
    }
    
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
    }
    
    private func addSubviews() {
        view.addSubview(mapView)
        view.addSubview(currentLocationButton)
        view.addSubview(bottomSheet)
//        mapView.addSubview(searchButton)
        mapView.addSubview(addButon)
        bottomSheet.addSubview(bottomSheetContentView)
        bottomSheet.addSubview(setLocationBottomSheet)
        setLocationBottomSheet.addSubview(setLocationDescriptionLabel)
        setLocationBottomSheet.addSubview(addressLabel)
        setLocationBottomSheet.addSubview(createGatherButton)
        mapView.addSubview(selectLocationPinImageView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            //mapView
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            //searchButton
//            searchButton.heightAnchor.constraint(equalToConstant: 56),
//            searchButton.widthAnchor.constraint(equalToConstant: 56),
//            searchButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 22),
//            searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -22),
            //addButton
            addButon.heightAnchor.constraint(equalToConstant: 56),
            addButon.widthAnchor.constraint(equalToConstant: 56),
            addButon.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 40),
            addButon.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -22),

//            addButon.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 22),
//            addButon.trailingAnchor.constraint(equalTo: searchButton.trailingAnchor),
            //currentLocationButton
            currentLocationButton.widthAnchor.constraint(equalToConstant: 44),
            currentLocationButton.heightAnchor.constraint(equalToConstant: 44),
            currentLocationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            currentLocationButton.bottomAnchor.constraint(equalTo: bottomSheet.topAnchor, constant: -30),
            //bottomSheet
            bottomSheet.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            bottomSheet.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            //bottomSheetContentView
            bottomSheetContentView.topAnchor.constraint(equalTo: bottomSheet.topAnchor),
            bottomSheetContentView.leadingAnchor.constraint(equalTo: bottomSheet.leadingAnchor),
            bottomSheetContentView.trailingAnchor.constraint(equalTo: bottomSheet.trailingAnchor),
            bottomSheetContentView.bottomAnchor.constraint(equalTo: bottomSheet.bottomAnchor),
            //setLocationBottomSheet
            setLocationBottomSheet.topAnchor.constraint(equalTo: bottomSheet.topAnchor),
            setLocationBottomSheet.leadingAnchor.constraint(equalTo: bottomSheet.leadingAnchor),
            setLocationBottomSheet.trailingAnchor.constraint(equalTo: bottomSheet.trailingAnchor),
            setLocationBottomSheet.bottomAnchor.constraint(equalTo: bottomSheet.bottomAnchor),
            //setLocationDescriptionLabel
            setLocationDescriptionLabel.topAnchor.constraint(equalTo: setLocationBottomSheet.topAnchor, constant: 30),
            setLocationDescriptionLabel.leadingAnchor.constraint(equalTo: setLocationBottomSheet.leadingAnchor, constant: 20),
            setLocationDescriptionLabel.widthAnchor.constraint(equalToConstant: 250),
            setLocationDescriptionLabel.heightAnchor.constraint(equalToConstant: 80),
            //addressLabel
            addressLabel.topAnchor.constraint(equalTo: setLocationDescriptionLabel.bottomAnchor, constant: 30),
            addressLabel.leadingAnchor.constraint(equalTo: setLocationBottomSheet.leadingAnchor, constant: 20),
            addressLabel.trailingAnchor.constraint(equalTo: setLocationBottomSheet.trailingAnchor, constant: -20),
            //createButton
            createGatherButton.heightAnchor.constraint(equalToConstant: 50),
            createGatherButton.leadingAnchor.constraint(equalTo: setLocationBottomSheet.leadingAnchor, constant: 20),
            createGatherButton.trailingAnchor.constraint(equalTo: setLocationBottomSheet.trailingAnchor, constant: -20),
            createGatherButton.bottomAnchor.constraint(equalTo: setLocationBottomSheet.bottomAnchor, constant: -5),
            //selectLocationPinImageView
            selectLocationPinImageView.widthAnchor.constraint(equalToConstant: 48),
            selectLocationPinImageView.heightAnchor.constraint(equalToConstant: 54),
            selectLocationPinImageView.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
            selectLocationPinImageView.bottomAnchor.constraint(equalTo: mapView.centerYAnchor, constant: -30)
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .Togaether.background
        
        navigationController?.navigationBar.isHidden = true
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
        disposeBag.insert (
            rx.viewWillAppear
                .map { _ in Reactor.Action.viewWillAppear }
                .bind(to: reactor.action),
//            searchButton.rx.throttleTap
//                .map { Reactor.Action.searchButtonTapped }
//                .bind(to: reactor.action),
            
            currentLocationButton.rx.throttleTap
                .bind { [unowned self] in
                    self.moveToCurrentLocation()
                },
            
            addButon.rx.throttleTap
                .bind { [unowned self] in
                    self.addButtonTouched()
                },
            
            addCloseBarButtonItem.rx.tap
                .bind { [unowned self] in
                    self.createGatherCloseButtonTouched()
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
                    let coordinate = mapView.selectedCoordinate(point: self.selectLocationPinImageView.center)
                    convertToAddressWith(
                        coordinate: CLLocation(
                            latitude: coordinate.latitude,
                            longitude: coordinate.longitude
                        )
                    )
                },
            
            bottomSheet.rx.tapGesture()
                .when(.recognized)
                .map { _ in Reactor.Action.bottomSheetTapped }
                .bind(to: reactor.action ),
            
            createGatherButton.rx.throttleTap
                .map { [unowned self] in
                    let coordinate = mapView.selectedCoordinate(point: self.selectLocationPinImageView.center)
                    return Reactor.Action.createGatherButtonTapped(
                        addressLabel.text ?? "",
                        CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                    )
                }
                .bind(to: reactor.action)
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
                }),
            
            reactor.state
                .map { $0.visibleCoordinate }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: Coordinate.seoulCityHall)
                .drive(with: self,
                       onNext: { this, coordinate in
                           switch coordinate {
                           case .seoulCityHall:
                               this.configureLocationManager()
                           default:
                               this.mapView.centerCoordinate = coordinate.toCLLocationCoordinate2D()
                               this.mapView.setCameraZoomRange(
                                   MKMapView.CameraZoomRange(minCenterCoordinateDistance: 500, maxCenterCoordinateDistance: 500),
                                   animated: false
                               )
                           }
                       }),
            
            reactor.state
                .map { $0.isCreateGatherButtonEnabled }
                .distinctUntilChanged()
                .asDriver(onErrorJustReturn: false)
                .drive(createGatherButton.rx.isEnabled)
        )
    }
    
    func bind(reactor: SearchReactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
    
    private func moveToCurrentLocation() {
        if let location = locationManager.location {
            mapView.setCenter(location.coordinate, animated: true)
        } else {
            configureSetting()
        }
    }
    
    private func addButtonTouched() {
        mapType = .add
        navigationController?.navigationBar.isHidden = false
        navigationItem.rightBarButtonItem = addCloseBarButtonItem
        navigationItem.title = "반려견 모임 생성"
//        searchButton.isHidden = true
        addButon.isHidden = true
        gatherInformationBottomSheetHeightConstraint.constant = 250
        bottomSheetContentView.isHidden = true
        setLocationBottomSheet.isHidden = false
        selectLocationPinImageView.isHidden = false
    }
    
    private func createGatherCloseButtonTouched() {
        mapType = .search
        self.navigationController?.navigationBar.isHidden = true
        navigationItem.title = nil
//        searchButton.isHidden = false
        addButon.isHidden = false
        gatherInformationBottomSheetHeightConstraint.constant = 0
        bottomSheetContentView.isHidden = true
        setLocationBottomSheet.isHidden = true
        selectLocationPinImageView.isHidden = true
        view.setNeedsLayout()
    }
    
    func convertToAddressWith(coordinate: CLLocation) {
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        if isAddressConvertRequestPossible {
            isAddressConvertRequestPossible = false
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
                    
                    self.isAddressConvertRequestPossible = true
                    DispatchQueue.main.async {
                        self.addressLabel.text = gatherAddress.joined(separator: " ")
                    }
                }
            })
        }
    }
    
    func configureSetting() {
        let alert = UIAlertController(title: "위치 권한 요청", message: "내 주변 모임 정보를 불러오려면 현재 위치가 필요합니다.", preferredStyle: .alert)
        let settingAction = UIAlertAction(title: "설정", style: .default) { action in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { UIAlertAction in
        }
        
        alert.addAction(settingAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
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
        if view.annotation is MKUserLocation || mapType == .add {
            mapView.deselectAnnotation(view.annotation, animated: false)
        }
        else if let view = view as? AnnotationView,
                let annotation = view.annotation as? Annotation
        {
            let defaultCoordinate = Coordinate.seoulCityHall
            let location = locationManager.location ?? CLLocation(latitude: defaultCoordinate.latitude, longitude: defaultCoordinate.longitude)
            
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
        
        if mapType == .search {
            view.deselect()
            UIView.animate(withDuration: 0.2, animations: {
                self.gatherInformationBottomSheetHeightConstraint.constant = 0
                self.bottomSheetContentView.isHidden = true
                self.view.layoutIfNeeded()
            })
        }
    }
}
