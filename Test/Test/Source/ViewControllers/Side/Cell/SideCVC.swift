//
//  SideCVC.swift
//  Test
//
//  Created by 양수빈 on 2022/01/03.
//

import UIKit

class SideCVC: UICollectionViewCell {
    static let identifier = "SideCVC"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        self.layer.cornerRadius = 20
    }
}
