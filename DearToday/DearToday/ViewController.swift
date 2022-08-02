//
//  ViewController.swift
//  DearToday
//
//  Created by 양수빈 on 2022/06/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var shadowButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }

    private func configUI() {
        view.backgroundColor = .systemIndigo
        
        shadowButton.sizeToFit()
        shadowButton.titleLabel?.textColor = .systemIndigo
        shadowButton.layer.backgroundColor = UIColor.white.withAlphaComponent(0.6).cgColor
        shadowButton.layer.cornerRadius = 10
        shadowButton.layer.shadowOffset = CGSize.zero
        shadowButton.layer.shadowColor = UIColor.red.withAlphaComponent(0.4).cgColor
//        shadowButton.layer.shadowRadius = 0.4
        shadowButton.layer.shadowOpacity = 1.0
        
    }

}

