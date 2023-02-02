//
//  HeaderCell.swift
//  HeaderDiffableDataSource
//
//  Created by 양수빈 on 2023/02/02.
//

import UIKit

class HeaderCell: UICollectionReusableView {
    
    static let identifier = "HeaderCell"
    
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        self.backgroundColor = .purple
        titleLabel.textColor = .white
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
