//
//  StackViewVC.swift
//  Test
//
//  Created by 양수빈 on 2021/09/15.
//

import UIKit

class StackViewVC: UIViewController {

    @IBOutlet weak var storyboardStackLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickFirstButton(_ sender: UIButton) {
        storyboardStackLabel.text = "Button1 clicked"
    }
    
    @IBAction func clickSecondButton(_ sender: UIButton) {
        storyboardStackLabel.text = "Button2 clicked"
    }
    
    @IBAction func clickThirdButton(_ sender: UIButton) {
        storyboardStackLabel.text = "Button3 clicked"
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
