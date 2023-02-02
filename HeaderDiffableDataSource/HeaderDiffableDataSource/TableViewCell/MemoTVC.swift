//
//  MemoTVC.swift
//  HeaderDiffableDataSource
//
//  Created by 양수빈 on 2023/02/02.
//

import UIKit
import SnapKit

class MemoTVC: UITableViewCell {
    
    static let identifier = "MemoTVC"
    
    private let titleLabel = UILabel()
    private let subLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(title: String, sub: String) {
        titleLabel.text = title
        subLabel.text = sub
    }
    
    private func setUI() {
        self.layer.cornerRadius = 16
        self.backgroundColor = .white
        subLabel.textColor = .gray
        subLabel.font = .systemFont(ofSize: 12)
    }
    
    private func setLayout() {
        self.addSubview(titleLabel)
        self.addSubview(subLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        subLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }
}
