//
//  ExampleCardCell.swift
//  Test
//
//  Created by 양수빈 on 2021/09/29.
//

import UIKit
import Foundation
import VerticalCardSwiper
import SnapKit

class ExampleCardCell: CardCell {
    static let identifier = "ExampleCell"
    
    var nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 12
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        nameLabel.text = "뇽안"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func layoutSubviews() {
////        self.layer.cornerRadius = 12
////        self.layoutSubviews()
////
////        nameLabel.translatesAutoresizingMaskIntoConstraints = false
////        nameLabel.snp.makeConstraints { make in
////            make.center.equalToSuperview()
////        }
////        nameLabel.text = "뇽안"
//    }
}
