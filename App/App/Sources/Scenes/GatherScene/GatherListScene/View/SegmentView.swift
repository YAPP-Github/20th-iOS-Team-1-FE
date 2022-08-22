//
//  SegmentView.swift
//  App
//
//  Created by 김나희 on 6/11/22.
//

import Foundation
import UIKit

final class SegmentView: UIView {
    private lazy var containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .Togaether.background
        
        return container
    }()

    internal lazy var segmentControl: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        segment.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        segment.insertSegment(withTitle: "참여중 모임", at: 0, animated: true)
        segment.insertSegment(withTitle: "내가 만든 모임", at: 1, animated: true)
        segment.insertSegment(withTitle: "종료된 모임", at: 2, animated: true)
        segment.selectedSegmentIndex = 0
        segment.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.Togaether.secondaryLabel,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ], for: .normal)
        segment.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.Togaether.primaryLabel,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)
        ], for: .selected)
        
        segment.addTarget(self, action: #selector(changeUnderLinePosition), for: .valueChanged)
        
        return segment
    }()
    
    @objc private func changeUnderLinePosition() {
        guard segmentControl.numberOfSegments != 0 else {
            return
        }
        let segmentIndex = CGFloat(segmentControl.selectedSegmentIndex)
        let segmentWidth = segmentControl.frame.width / CGFloat(segmentControl.numberOfSegments)
        let leadingDistance = segmentWidth * segmentIndex
        UIView.animate(withDuration: 0.2, animations: {
            self.leadingDistance.constant = leadingDistance
            self.layoutIfNeeded()
        })
    }

    private lazy var underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .Togaether.mainGreen
        
        return view
    }()

    private lazy var leadingDistance: NSLayoutConstraint = {
        return underLineView.leadingAnchor.constraint(equalTo: segmentControl.leadingAnchor)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configureLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(segmentControl)
        containerView.addSubview(underLineView)
    }
    
    private func configureLayout() {
        guard segmentControl.numberOfSegments != 0 else {
            return
        }
        NSLayoutConstraint.useAndActivateConstraints([
            containerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            containerView.heightAnchor.constraint(equalToConstant: 42),
            
            segmentControl.topAnchor.constraint(equalTo: containerView.topAnchor),
            segmentControl.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            segmentControl.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            segmentControl.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
    
            underLineView.bottomAnchor.constraint(equalTo: segmentControl.bottomAnchor),
            underLineView.heightAnchor.constraint(equalToConstant: 2),
            leadingDistance,
            underLineView.widthAnchor.constraint(equalTo: segmentControl.widthAnchor, multiplier: 1 / CGFloat(segmentControl.numberOfSegments))
            ])
    }
    
    internal func settingInitialSegmentView() {
        segmentControl.selectedSegmentIndex = 0
        changeUnderLinePosition()
    }
}
