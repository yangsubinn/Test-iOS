//
//  ViewController.swift
//  ShareExtension
//
//  Created by 양수빈 on 2022/11/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getDatafromUserDefault()
    }

    func getDatafromUserDefault() {
        if let userDefaults = UserDefaults(suiteName: "group.subin.Share") {
            if let data = userDefaults.data(forKey: "image") {
                imageView.image = UIImage(data: data)
            }
            
            if let text = userDefaults.string(forKey: "text") {
                testLabel.text = text
            }
        }
    }
}

