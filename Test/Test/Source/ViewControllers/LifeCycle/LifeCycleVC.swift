//
//  LifeCycleVC.swift
//  Test
//
//  Created by 양수빈 on 2022/03/24.
//

import UIKit

class LifeCycleVC: UIViewController {

    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("1️⃣ viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("2️⃣ viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("3️⃣ viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("4️⃣ viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("5️⃣ viewDidDisappear")
    }
    
    // MARK: - @IBAction

    @IBAction func touchUpButton(_ sender: Any) {
        guard let nextVC = UIStoryboard(name: "LifeCycle", bundle: nil).instantiateViewController(withIdentifier: "SecondLifeCycleVC") as? SecondLifeCycleVC else { return }
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
