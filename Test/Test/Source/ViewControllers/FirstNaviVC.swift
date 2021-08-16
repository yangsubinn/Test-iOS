//
//  FirstNaviVC.swift
//  Test
//
//  Created by 양수빈 on 2021/08/16.
//

import UIKit
import SnapKit

class FirstNaviVC: UIViewController {
    
    let titleLabel = UILabel()
    let nextButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI
        navigationController?.setNavigationBarHidden(true, animated: false) /// navigation bar 숨기기
        navigationController?.interactivePopGestureRecognizer?.delegate = nil /// navigation bar 숨겨도 swipe back gesture 사용할 수 있도록
        
        titleLabel.text = "하나둘셋 얍"
        nextButton.setTitle("go", for: .normal)
        nextButton.backgroundColor = .purple
        nextButton.layer.cornerRadius = 25
        
        view.backgroundColor = .white
        
        // Layout
        view.addSubview(titleLabel)
        view.addSubview(nextButton)
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.width.equalTo(120)
            make.height.equalTo(50)
        }
        
        // Action
        nextButton.addTarget(self, action: #selector(touchUpGoButton), for: .touchUpInside)
        
    }
    
    @objc func touchUpGoButton() {
        print("clicked")
//        guard let nextVC = storyboard?.instantiateViewController(identifier: "SecondNaviVC") as? SecondNaviVC else { return }
        let nextVC = SecondNaviVC()
        self.navigationController?.pushViewController(nextVC, animated: true)
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
