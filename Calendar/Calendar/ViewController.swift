//
//  ViewController.swift
//  Calendar
//
//  Created by 양수빈 on 2021/12/28.
//

import UIKit

import FSCalendar

class ViewController: UIViewController {

    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var dateLabel: UILabel!
    
    var formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegate()
        configUI()
    }
    
    func setupDelegate() {
        calendar.delegate = self
        calendar.dataSource = self
    }
    
    func configUI() {
        /// 달력의 맨 위의 년도, 월의 색깔 : 상단 가운데 December 2021
        calendar.appearance.headerTitleColor = .purple
        /// 오늘 날짜 색상
        calendar.appearance.todayColor = .blue
        /// 오늘 날짜가 선택됐을 때 날짜 색상
        calendar.appearance.todaySelectionColor = .red
        /// 선택된 날짜 색상
        calendar.appearance.selectionColor = .orange
        
        /// 달력의 평일 날짜 색깔
        calendar.appearance.titleDefaultColor = .black
        /// 달력의 토,일 날짜 색깔
        calendar.appearance.titleWeekendColor = .red
        /// 달력의 요일 글자 색깔
        calendar.appearance.weekdayTextColor = .orange
        /// 달력의 년월 글자 바꾸기
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        /// 달력의 요일 글자 한국어로 바꾸는 방법
        calendar.locale = Locale(identifier: "ko_KR")
        /// 양 옆 년월에 흐릿하게 보이는 애들 없애기
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        /// 달력 스크롤 방향
        calendar.scrollDirection = .vertical
    }
    
//    func setUpEvents() {
//        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "ko_KR")
//        formatter.dateFormat = "yyyy-MM-dd"
//        let xmas = formatter.date(from: "2020-12-25")
//        let sampledate = formatter.date(from: "2020-08-22")
//        events = [xmas!, sampledate!]
//    }

}

extension ViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formatter.dateFormat = "yyyy-MM-dd"
        let selectDate = formatter.string(from: date)
        
        dateLabel.text = selectDate
    }
}

