//
//  Calendar.swift
//  CalendarTest
//
//  Created by 양수빈 on 2022/12/14.
//

import UIKit

import SnapKit

class CalendarView: UIView {
    
    // MARK: - Properties
    
    private let now = Date()
    private var calendar = Calendar.current
    private let dateFormatter = DateFormatter()
    private var components = DateComponents()
    private let weeks: [String] = Week.allCases.map { $0.ko }
    private var months: [Int] = [] // 5 -> 750
    private var days: [String] = []
    private var daysCountInMonth = 0
    private var weekdayAdding = 0
    private var cellSize = CGSize()
//    private lazy var lastContentOffset: CGFloat = ceil(Double(months.count/2))*UIScreen.main.bounds.width
    private lazy var lastIndex = ceil(Double(months.count/2))
    
    // MARK: - UI Components
    
    private let yearMonthLabel = UILabel()
    private var diffableDataSource: UICollectionViewDiffableDataSource<Section, String>!
    private let weekCVFlowLayout = UICollectionViewFlowLayout()
    private let monthCVFlowLayout = UICollectionViewFlowLayout()
    private lazy var weekCV = UICollectionView(frame: .zero, collectionViewLayout: weekCVFlowLayout)
    private lazy var monthCV = UICollectionView(frame: .zero, collectionViewLayout: monthCVFlowLayout)
    
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        setDateFormatter()
        setCalendar()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setDelegate()
        setCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Custom Methods

extension CalendarView {
    private func setDelegate() {
        self.weekCV.delegate = self
        self.weekCV.dataSource = self
        
//        self.diffableDataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: self.monthCV) {(_ UICollectionView, indexPath, _ days) -> UICollectionViewCell? in
//
//            guard let cell = self.monthCV.dequeueReusableCell(withReuseIdentifier: MonthCVC.identifier, for: indexPath) as? MonthCVC else { return UICollectionViewCell() }
//
//            return cell
//        }
        
        self.monthCV.dataSource = self //diffableDataSource
        self.monthCV.delegate = self
    }
    
    private func setCollectionView() {
        monthCV.isPagingEnabled = true
        
        weekCV.register(WeekCVC.self, forCellWithReuseIdentifier: WeekCVC.identifier)
        monthCV.register(MonthCVC.self, forCellWithReuseIdentifier: MonthCVC.identifier)
        
        weekCVFlowLayout.scrollDirection = .horizontal
        monthCVFlowLayout.scrollDirection = .horizontal
        
        monthCV.scrollToItem(at: IndexPath.init(item: Int(floor(Double(months.count/2))), section: 0), at: .centeredHorizontally, animated: false)
    }
    
    private func setDateFormatter() {
        dateFormatter.dateFormat = "yyyy년 M월"
        components.year = calendar.component(.year, from: now)
        components.month = calendar.component(.month, from: now)
        components.day = 1
    }
    
    private func setCalendar() {
        let now = calendar.component(.month, from: now)
        months.append(contentsOf: [now-2, now-1, now, now+1, now+2])
        
        // TODO: - swipe에 따라 month 변경
        self.yearMonthLabel.text = dateFormatter.string(from: calendar.date(from: components)!)
    }
    
    private func changeMonth(_ m: Int) {
        components.month! += m
//        self.calculation()
        self.yearMonthLabel.text = dateFormatter.string(from: calendar.date(from: components)!)
    }
    
    private func calculation() {
        let firstDayOfMonth = calendar.date(from: components)
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth!)
        daysCountInMonth = calendar.range(of: .day, in: .month, for: firstDayOfMonth!)!.count
        weekdayAdding = 2 - firstWeekday
        
        self.yearMonthLabel.text = dateFormatter.string(from: firstDayOfMonth!)

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

// MARK: - UICollectionView

extension CalendarView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case weekCV:
            return 7
        case monthCV:
            return months.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case weekCV:
            guard let weekCell = weekCV.dequeueReusableCell(withReuseIdentifier: WeekCVC.identifier, for: indexPath) as? WeekCVC else { return UICollectionViewCell() }
            weekCell.setWeek(weeks[indexPath.row])
            return weekCell
        case monthCV:
            guard let monthCell = monthCV.dequeueReusableCell(withReuseIdentifier: MonthCVC.identifier, for: indexPath) as? MonthCVC else { return UICollectionViewCell() }
            monthCell.setMonth(months[indexPath.row])
            return monthCell
        default:
            return UICollectionViewCell()
        }
    }
}

extension CalendarView: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print(targetContentOffset.pointee.x)
        let currentIndex = targetContentOffset.pointee.x/UIScreen.main.bounds.width
        if lastIndex < currentIndex {
            self.changeMonth(+1)
        } else {
            self.changeMonth(-1)
        }
        
        self.lastIndex = currentIndex
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == weekCV {
            let spacing = self.weekCV.frame.width - (cellSize.width * 7)
            return spacing / 6
        }
        return 0
    }
}

extension CalendarView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case weekCV:
            let width = (self.weekCV.frame.width / 7) - 10
            let height = width + 10
            cellSize = CGSize(width: width, height: height)
            return cellSize
        case monthCV:
            let width = self.monthCV.frame.width
            let height = self.monthCV.frame.height
            return CGSize(width: width, height: height)
        default:
            return CGSize.zero
        }
    }
}

// MARK: - UI & Components

extension CalendarView {
    private func setUI() {
        yearMonthLabel.textColor = .purple
        yearMonthLabel.font = .systemFont(ofSize: 18)
        yearMonthLabel.textAlignment = .center
    }
    
    private func setLayout() {
        self.addSubviews([yearMonthLabel, weekCV, monthCV])
        
        yearMonthLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(20)
        }
        
        weekCV.snp.makeConstraints { make in
            make.top.equalTo(yearMonthLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        monthCV.snp.makeConstraints { make in
            make.top.equalTo(weekCV.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
