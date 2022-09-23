//
//  ViewController.swift
//  CoordinatorPattern
//
//  Created by 양수빈 on 2022/09/23.
//

import UIKit

class ViewController: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buyButtonTapped(_ sender: Any) {
        print("buyButtonTapped")
        coordinator?.buySubscription()
    }
    
    @IBAction func createButtonTapped(_ sender: Any) {
        print("createButtonTapped")
        coordinator?.createAccount()
    }
}

