//
//  HeaderTVC.swift
//  HeaderDiffableDataSource
//
//  Created by 양수빈 on 2023/02/02.
//

import UIKit
import SnapKit

class HeaderTVC: UITableViewHeaderFooterView {
    
    static let identifier = "HeaderTVC"
    
    private let titleLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        self.backgroundColor = .purple
        titleLabel.textColor = .gray
    }
    
    private func setupLayout() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
    }
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
}
