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
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.isPitchEnabled = false
        return mapView
    }()
    
    private lazy var searchButton: CircularButton =  {
        let button = CircularButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.Togaether.mainYellow
        return button
    }()
    
    private var notificationItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: SearchViewController.self, action: nil)
        barButtonItem.tintColor = .label
        return barButtonItem
    }()
    
    var disposeBag = DisposeBag()
    
    init(reactor: SearchReactor) {
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
        reactor?.action.onNext(.viewDidLoad)
        
        if let reactor = reactor {
            bind(reactor: reactor)
        }
    }

    private func addSubviews() {
        view.addSubview(mapView)
        mapView.addSubview(searchButton)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            //mapView
            mapView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            //searchButton
            searchButton.heightAnchor.constraint(equalToConstant: 56),
            searchButton.widthAnchor.constraint(equalToConstant: 56),
            searchButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 22),
            searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -22),
        ])
    }
    
    private func configureUI() {
        self.view.backgroundColor = .systemBackground
        self.navigationItem.rightBarButtonItem = notificationItem
    }
    
    private func bindAction(with reactor: SearchReactor) {
        disposeBag.insert(
        )
    }
    
    private func bindState(with reactor: SearchReactor) {
        disposeBag.insert(
            reactor.state
                .map { MKCoordinateRegion(
                    center: $0.currentCoordinate.toCLLocationCoordinate2D(),
                    span: MKCoordinateSpan(
                        latitudeDelta: $0.currentSpan,
                        longitudeDelta: $0.currentSpan)
                ) }
                .distinctUntilChanged()
                .bind(to: mapView.rx.region)
        )
    }
    
    func bind(reactor: SearchReactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
}

extension SearchViewController: MKMapViewDelegate {
    
}

