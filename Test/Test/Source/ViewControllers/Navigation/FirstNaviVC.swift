//
//  FirstNaviVC.swift
//  Test
//
//  Created by 양수빈 on 2021/08/16.
//

import UIKit
import SnapKit

class FirstNaviVC: UIViewController {
    
    // MARK: - Properties
    let titleLabel = UILabel()
    let nextButton = UIButton()
    let userName = UILabel()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        configUI()
        setupLayout()
        setupAddTarget()
    }
    
    
    // MARK: - Custom Method
    private func configUI() {
        view.backgroundColor = .white
        
        titleLabel.text = "하나둘셋 얍"
        
        nextButton.setTitle("go", for: .normal)
        nextButton.backgroundColor = .purple
        nextButton.layer.cornerRadius = 25
        
//        userName.backgroundColor = .blue
//        userName.text = UserDefaults.standard.string(forKey: "nameState")
    }
    
    private func setupNavigation() {
        navigationController?.setNavigationBarHidden(true, animated: false) /// navigation bar 숨기기
        navigationController?.interactivePopGestureRecognizer?.delegate = nil /// navigation bar 숨겨도 swipe back gesture 사용할 수 있도록
    }
    
    private func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(nextButton)
//        view.addSubview(userName)
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.width.equalTo(120)
            make.height.equalTo(50)
        }
        
//        userName.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalToSuperview().offset(80)
//            make.leading.trailing.equalToSuperview().inset(20)
//            make.height.equalTo(60)
//        }
    }
    
    private  func setupAddTarget() {
        nextButton.addTarget(self, action: #selector(touchUpGoButton), for: .touchUpInside)
    }
    
    
    // MARK: - @objc
    @objc func touchUpGoButton() {
        print("clicked")
        let nextVC = SecondNaviVC()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
