//
//  DayCVC.swift
//  CalendarTest
//
//  Created by 양수빈 on 2022/12/14.
//

import UIKit

import SnapKit

class WeekCVC: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "WeekCVC"
    
    // MARK: - UI Components
    
    private let dayLabel = UILabel()
    
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
        dayLabel.font = .systemFont(ofSize: 14)
        dayLabel.textColor = .purple.withAlphaComponent(0.8)
    }
    
    private func setLayout() {
        self.addSubviews([dayLabel])
        
        dayLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

// MARK: - Custom Methods

extension WeekCVC {
    func setWeek(_ week: String) {
        self.dayLabel.text = week
    }
}
