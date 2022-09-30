//
//  ViewController.swift
//  BuildTest
//
//  Created by 양수빈 on 2022/09/30.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appName = Bundle.main.infoDictionary?["AppName"] as? String,
              let appURL = Bundle.main.infoDictionary?["AppURL"] as? String else { return }
        
        print(appName, appURL ?? "---")
        
        nameLabel.text = appName
        urlLabel.text = appURL
    }


}

