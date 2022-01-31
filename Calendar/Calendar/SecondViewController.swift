//
//  SecondViewController.swift
//  Calendar
//
//  Created by 양수빈 on 2021/12/28.
//

import UIKit

class SecondViewController: UIViewController {
    
    // MARK: - Properties
    let now = Date()
    let dateFormatter = DateFormatter()
    var cal = Calendar.current
    var components = DateComponents()
    var weeks: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    var days: [String] = []
    var daysCountInMonth = 0
    var weekdayAdding = 0

    // MARK: - @IBOutlet
    @IBOutlet weak var yearMonthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    // MARK: - Custom Method
    private func initView() {
        self.setupCollectionView()
        
        dateFormatter.dateFormat = "yyyy년 M월"
        components.year = cal.component(.year, from: now)
        components.month = cal.component(.month, from: now)
        components.day = 1
        
        self.calculation()
    }
    
    private func calculation() {
        let firstDayOfMonth = cal.date(from: components)
        let firstWeekday = cal.component(.weekday, from: firstDayOfMonth!)
        daysCountInMonth = cal.range(of: .day, in: .month, for: firstDayOfMonth!)!.count
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
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "CustomCVC", bundle: nil), forCellWithReuseIdentifier: "calendarCell")
    }
    
    // MARK: - @IBAction
    @IBAction func touchUpToPrev(_ sender: Any) {
        components.month = components.month! - 1
        self.calculation()
        self.collectionView.reloadData()
    }
    
    @IBAction func touchUpToNext(_ sender: Any) {
        components.month = components.month! + 1
        self.calculation()
        self.collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension SecondViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return 7
        default:
            return self.days.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as! CustomCVC
        
        switch indexPath.section {
        case 0:
            cell.dateLabel.text = weeks[indexPath.row]
        default:
            cell.dateLabel.text = days[indexPath.row]
        }
        
        if indexPath.row % 7 == 0 {
            cell.dateLabel.textColor = .red
        } else if indexPath.row % 7 == 6 {
            cell.dateLabel.textColor = .blue
        } else {
            cell.dateLabel.textColor = .black
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 7) - 10
        let height = width + 10
        return CGSize(width: width, height: height)
    }
}
