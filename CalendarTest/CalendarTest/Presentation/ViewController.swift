//
//  ViewController.swift
//  CalendarTest
//
//  Created by 양수빈 on 2022/12/12.
//

import UIKit

import FSCalendar

class ViewController: UIViewController {

    @IBOutlet weak var calendar: FSCalendar!
    
    private let dateFormatter = DateFormatter()
    private var dateList: [Date] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDate()
        setDelegate()
    }

    @IBAction func removeButtonTapped(_ sender: Any) {
        while !dateList.isEmpty {
            self.calendar.deselect(dateList.removeFirst())
        }
    }
    
    private func setUI() {
        calendar.backgroundColor = .white
        
        /// 달력의 맨 위의 년도, 월의 색깔 : 상단 가운데 December 2021
        calendar.appearance.headerTitleColor = .purple
        /// 오늘 날짜 색상
        calendar.appearance.todayColor = .purple.withAlphaComponent(0.4)
        /// 오늘 날짜가 선택됐을 때 날짜 색상
        calendar.appearance.todaySelectionColor = .systemMint
        /// 선택된 날짜 색상
        calendar.appearance.selectionColor = .systemMint
        /// 달력의 평일 날짜 색깔
        calendar.appearance.titleDefaultColor = .black
        /// 달력의 토,일 날짜 색깔
        calendar.appearance.titleWeekendColor = .purple
        /// 달력의 요일 글자 색깔
        calendar.appearance.weekdayTextColor = .purple.withAlphaComponent(0.7)
        /// 달력의 년월 글자 바꾸기
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        /// 달력의 요일 글자 한국어로 바꾸는 방법
        calendar.locale = Locale(identifier: "ko_KR")
        /// 양 옆 년월에 흐릿하게 보이는 애들 없애기
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        /// 달력 스크롤 방향
        calendar.scrollDirection = .vertical
        /// 다중 선택 가능
        calendar.allowsMultipleSelection = true
        /// 꾹 누르고 스와이프해서 선택
        calendar.swipeToChooseGesture.isEnabled = true
        /// 선택된 날짜 radius (0~1)
        calendar.appearance.borderRadius = 0.5
    }
    
    private func setDate() {
        dateFormatter.dateFormat = "yyyy-mm-dd"
    }
    
    private func setDelegate() {
        calendar.delegate = self
        calendar.dataSource = self
    }
}

extension ViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + "선택됨")
        dateList.append(date)
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + "해제됨")
        dateList.remove(at: dateList.firstIndex(of: date)!)
    }
}

