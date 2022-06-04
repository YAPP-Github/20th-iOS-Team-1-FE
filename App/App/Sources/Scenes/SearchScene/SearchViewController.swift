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
        return mapView
    }()
    
    private lazy var searchButton: CircularButton =  {
        let button = CircularButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "Jump YR")
        return button
    }()
    
    private var navigationView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var titleLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Logo_S")
        return imageView
    }()
    
    private var notificationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Notification"), for: .normal)
        button.adjustsImageWhenHighlighted = false
        button.tintColor = .gray
        return button
    }()
    
    private var settingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Menu"), for: .normal)
        button.tintColor = .label
        return button
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
        
        if let reactor = reactor {
            bind(reactor: reactor)
        }
    }

    private func addSubviews() {
        view.addSubview(mapView)
        view.addSubview(navigationView)
        mapView.addSubview(searchButton)
        
        navigationView.addSubview(titleLogoImageView)
        navigationView.addSubview(notificationButton)
        navigationView.addSubview(settingButton)
        
    }
    
    private func configureLayout() {
        NSLayoutConstraint.useAndActivateConstraints([
            // navigationView
            navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            navigationView.heightAnchor.constraint(equalTo: navigationView.widthAnchor, multiplier: 1/7),
            //mapView
            mapView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            //searchButton
            searchButton.heightAnchor.constraint(equalToConstant: 56),
            searchButton.widthAnchor.constraint(equalToConstant: 56),
            searchButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 22),
            searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -22),
            //titleLogoImageView
            titleLogoImageView.topAnchor.constraint(equalTo: navigationView.topAnchor, constant: 4),
            titleLogoImageView.leadingAnchor.constraint(equalTo: navigationView.leadingAnchor,constant: 20),
            titleLogoImageView.bottomAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: -7),
            titleLogoImageView.widthAnchor.constraint(equalTo: titleLogoImageView.heightAnchor, multiplier: 60/44),
            //settingButton
            settingButton.topAnchor.constraint(equalTo: navigationView.topAnchor, constant: 12),
            settingButton.bottomAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: -11),
            settingButton.trailingAnchor.constraint(equalTo: navigationView.trailingAnchor, constant: -12),
            settingButton.widthAnchor.constraint(equalTo: settingButton.heightAnchor),
            //notificationButton
            notificationButton.topAnchor.constraint(equalTo: navigationView.topAnchor, constant: 15),
            notificationButton.bottomAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: -14),
            notificationButton.trailingAnchor.constraint(equalTo: settingButton.leadingAnchor, constant: -10),
            notificationButton.widthAnchor.constraint(equalTo: notificationButton.heightAnchor)
        ])
    }
    
    private func configureUI() {
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func bindAction(with reactor: SearchReactor) {
        
    }
    
    private func bindState(with reactor: SearchReactor) {
        
    }
    
    func bind(reactor: SearchReactor) {
        bindAction(with: reactor)
        bindState(with: reactor)
    }
}
