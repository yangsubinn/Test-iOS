//
//  ViewController.swift
//  Test-APNS
//
//  Created by 양수빈 on 2022/10/12.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    let notificationCenter = UNUserNotificationCenter.current()

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.requestNotificationAuthorization()
    }
    
    /// 푸시알림 권한 허용 요청
    func requestNotificationAuthorization() {
        let authOptions: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        notificationCenter.requestAuthorization(options: authOptions) { success, error in
            if let error = error {
                print(error)
            }
        }
    }

    /// 자체 푸시 알림
    @IBAction func pushButtonTapped(_ sender: Any) {
        print("pushButtonTapped")
        notificationCenter.removeAllPendingNotificationRequests()
        
        let push = UNMutableNotificationContent()
        push.title = "title임"
        push.subtitle = "subtitle임"
        push.body = "bodybody"
//        push.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: push, trigger: trigger)
        notificationCenter.add(request, withCompletionHandler: nil)
    }
    
}

