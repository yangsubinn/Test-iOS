//
//  SecondNaviVC.swift
//  Test
//
//  Created by 양수빈 on 2021/08/16.
//

import UIKit
import SnapKit

class SecondNaviVC: UIViewController {
    
    let titleLabel = UILabel()
    let backButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        titleLabel.text = "뿅 도착"
        backButton.setTitle("back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.backgroundColor = .orange
        backButton.layer.cornerRadius = 25
        
        view.addSubview(titleLabel)
        view.addSubview(backButton)
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.width.equalTo(120)
            make.height.equalTo(50)
        }
        
        backButton.addTarget(self, action: #selector(touchUpBackButton), for: .touchUpInside)
        
    }
    
    @objc
    func touchUpBackButton() {
        navigationController?.popViewController(animated: true)
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
