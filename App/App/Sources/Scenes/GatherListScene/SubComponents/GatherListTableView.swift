//
//  GatherListTableView.swift
//  App
//
//  Created by 김나희 on 6/9/22.
//

import UIKit

final class GatherListTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .Togaether.background
        registerCell(type: GatherListCell.self)
    }
}
