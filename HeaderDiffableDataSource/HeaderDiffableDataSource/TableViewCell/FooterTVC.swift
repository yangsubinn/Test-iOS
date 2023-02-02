//
//  FooterTVC.swift
//  HeaderDiffableDataSource
//
//  Created by 양수빈 on 2023/02/02.
//

import UIKit
import SnapKit

class FooterTVC: UITableViewHeaderFooterView {
    
    static let identifier = "FooterCell"
    
    let titleLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        self.backgroundColor = .green
        titleLabel.text = "선수 추가"
        titleLabel.textColor = .red
    }
    
    private func setupLayout() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func hiddenFooter() {
        self.isHidden = true
    }
    
    func showFooter() {
        self.isHidden = false
    }
}
