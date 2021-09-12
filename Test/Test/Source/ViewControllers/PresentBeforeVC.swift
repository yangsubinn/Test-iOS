//
//  PresentBeforeVC.swift
//  Test
//
//  Created by 양수빈 on 2021/09/11.
//

import UIKit

class PresentBeforeVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = "안녕하세요"
        titleLabel.textColor = .blue
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        // 버튼 클릭시 동작
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "PresentModalVC") as? PresentModalVC else { return }
        present(nextVC, animated: true, completion: nil)
        /// present(modal)
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
