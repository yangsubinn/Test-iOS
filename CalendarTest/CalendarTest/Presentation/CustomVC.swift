//
//  CustomVC.swift
//  CalendarTest
//
//  Created by 양수빈 on 2022/12/15.
//

import UIKit

import SnapKit

class CustomVC: UIViewController {
    
    // MARK: - UI Components
    
    private let calendar = CalendarView()
    
    // MARK: - View Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    // MARK: - UI & Components
    
    private func setLayout() {
        self.view.addSubview(calendar)
        
        calendar.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(self.view.frame.height / 2)
        }
    }
}
