//
//  SecondNaviVC.swift
//  Test
//
//  Created by 양수빈 on 2021/08/16.
//

import UIKit
import SnapKit

class SecondNaviVC: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    let titleLabel = UILabel()
    let backButton = UIButton()
    let toggleButton = UISwitch()
    let nameTextField = UITextField()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        setupLayout()
        setupAddTarget()
        setUserDefault()
    }
    
    // MARK: - Custom Method
    private func configUI() {
        view.backgroundColor = .white
        
        nameTextField.delegate = self
        nameTextField.backgroundColor = .gray
        
        titleLabel.text = "뿅 도착"
        backButton.setTitle("back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.backgroundColor = .orange
        backButton.layer.cornerRadius = 25
    }
    
    private func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(backButton)
        view.addSubview(toggleButton)
        view.addSubview(nameTextField)
        
        nameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(80)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.width.equalTo(120)
            make.height.equalTo(50)
        }
        
        toggleButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(titleLabel.snp.top).offset(-40)
        }
    }
    
    private func setupAddTarget() {
        backButton.addTarget(self, action: #selector(touchUpBackButton), for: .touchUpInside)
        toggleButton.addTarget(self, action: #selector(toggleSwitchButton), for: .touchUpInside)
    }
    
    func setUserDefault() {
        toggleButton.isOn = UserDefaults.standard.bool(forKey: "switchState")
        nameTextField.text = UserDefaults.standard.string(forKey: "nameState")
    }
    
    // MARK: - @objc
    @objc
    func touchUpBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func toggleSwitchButton() {
        UserDefaults.standard.set(toggleButton.isOn, forKey: "switchState")
        UserDefaults.standard.set(nameTextField.text, forKey: "nameState")
    }
}
