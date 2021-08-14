//
//  ViewController.swift
//  Test
//
//  Created by 양수빈 on 2021/08/15.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func touchUpFirstButton(_ sender: UIButton) {
        /// 약하고 짧은 진동
        AudioServicesPlaySystemSound(1519)
    }
    
    
    @IBAction func touchUpSecondButton(_ sender: UIButton) {
        /// 덜 약하고 짧은 진동
        AudioServicesPlaySystemSound(1520)
    }
    
    @IBAction func touchUpThirdButton(_ sender: UIButton) {
        /// nope 두 번 진동
        AudioServicesPlaySystemSound(1521)
    }
    
    @IBAction func touchUpFourthButton(_ sender: UIButton) {
        /// 쎄고 긴 진동
        AudioServicesPlaySystemSound(4095)
    }
}

