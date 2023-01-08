//
//  CollectionViewCell.swift
//  Shadow
//
//  Created by 양수빈 on 2022/12/30.
//

import UIKit

import SnapKit

class CollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    
    static let identifier = "CollectionViewCell"
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel()
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        
        self.layer.shadowColor = UIColor(red: 0.796, green: 0.788, blue: 0.878, alpha: 0.4).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 12
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.4)
//        self.layer.shadowPath = CGPath(rect: CGRect(x: 0, y: 4, width: 0.0, height: 0.4), transform: .none)
        
        self.titleLabel.text = "title"
    }
    
    private func setLayout() {
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
