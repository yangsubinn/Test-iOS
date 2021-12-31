//
//  SecondViewController.swift
//  Calendar
//
//  Created by 양수빈 on 2021/12/28.
//

import UIKit

import FSCalendar

class SecondViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    var calendar = FSCalendar()

    override func viewDidLoad() {
        super.viewDidLoad()

        calendar.delegate = self
        calendar.dataSource = self
        
        view.addSubview(calendar)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
