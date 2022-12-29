//
//  DateCVC.swift
//  CalendarTest
//
//  Created by 양수빈 on 2022/12/14.
//

import UIKit

import SnapKit

class DateCVC: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "DateCVC"
    
    // MARK: - UI Components
    
    private let dateLabel = UILabel()
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.textColor = .black
    }
    
    private func setLayout() {
        self.addSubviews([dateLabel])
        
        dateLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

// MARK: - Custom Methods

extension DateCVC {
    func setDate(_ date: String) {
        dateLabel.text = date
    }
}
