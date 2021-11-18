//
//  HeaderCVC.swift
//  Test
//
//  Created by 양수빈 on 2021/11/18.
//

import UIKit

class HeaderCVC: UICollectionViewCell {
    
    static let identifier = "HeaderCVC"
    
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        self.backgroundColor = .lightGray
        titleLabel.sizeToFit()
    }
    
    func setupLayout() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
