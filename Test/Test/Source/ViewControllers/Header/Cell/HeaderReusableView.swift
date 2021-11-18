//
//  HeaderReusableView.swift
//  Test
//
//  Created by 양수빈 on 2021/11/18.
//

import UIKit

class HeaderReusableView: UICollectionReusableView {
    
    static let identifier = "HeaderReusableView"
    
    let titleLabel = UILabel()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        self.backgroundColor = .purple
        titleLabel.text = "HeaderReusableView"
        titleLabel.textColor = .white
    }
    
    func setupLayout() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
