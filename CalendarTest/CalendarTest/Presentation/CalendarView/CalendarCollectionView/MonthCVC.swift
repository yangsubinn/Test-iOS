//
//  MonthCVC.swift
//  CalendarTest
//
//  Created by 양수빈 on 2022/12/14.
//

import UIKit

import SnapKit

class MonthCVC: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "MonthCVC"
    private let now = Date()
    private var calendar = Calendar.current
    private let dateFormatter = DateFormatter()
    private var components = DateComponents()
    private let weeks: [String] = Week.allCases.map { $0.ko }
    private var days: [String] = []
    private var daysCountInMonth = 0
    private var weekdayAdding = 0
    
    // MARK: - UI Components
    
    private let collectionViewFlowLayout = UICollectionViewFlowLayout()
    private lazy var dateCV = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        setDelegate()
        setRegister()
//        setDateFormatter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Custom Methods

extension MonthCVC {
    private func setDelegate() {
        self.dateCV.delegate = self
        self.dateCV.dataSource = self
    }
    
    private func setRegister() {
        self.dateCV.register(DateCVC.self, forCellWithReuseIdentifier: DateCVC.identifier)
    }
    
    private func setDateFormatter() {
//        dateFormatter.dateFormat = "yyyy년 M월"
        components.year = calendar.component(.year, from: now)
        components.month = calendar.component(.month, from: now)
        components.day = 1

        self.calculation()
    }
    
    func setMonth(_ month: Int) {
        components.month = month > 12 ? month - 12 : month
        self.calculation()
    }

    private func calculation() {
        let firstDayOfMonth = calendar.date(from: components)
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth!)
        daysCountInMonth = calendar.range(of: .day, in: .month, for: firstDayOfMonth!)!.count
        weekdayAdding = 2 - firstWeekday

        self.days.removeAll()

        for day in weekdayAdding...daysCountInMonth {
            if day < 1 {
                self.days.append("")
            } else {
                self.days.append(String(day))
            }
        }
    }
}

extension MonthCVC: UICollectionViewDelegate {
    
}

extension MonthCVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 7) - 10
        let height = width + 10
        return CGSize(width: width, height: height)
    }
}

extension MonthCVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dateCell = dateCV.dequeueReusableCell(withReuseIdentifier: DateCVC.identifier, for: indexPath) as? DateCVC else { return UICollectionViewCell() }
        dateCell.setDate(days[indexPath.row])
        return dateCell
    }
    
    
}

// MARK: - UI & Layout

extension MonthCVC {
    private func setUI() {
        dateCV.backgroundColor = .clear
        dateCV.isScrollEnabled = true
    }
    
    private func setLayout() {
        self.addSubviews([dateCV])
        
        dateCV.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
    }
}


