//
//  ViewController.swift
//  KeyboardAction
//
//  Created by 양수빈 on 2022/08/03.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let textField = UITextField()
    private let bottomButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
        setNoti()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeNoti()
    }
    
    private func setNoti() {
        // 키보드가 최초 올라올 때, 형태가 바뀔 때(일반 -> 이모지 키보드 등) 모두 인식해서 노티를 보내줌
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardMoveUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardMoveDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeNoti() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardMoveUp(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print(keyboardSize)
            UIView.animate(withDuration: 0.3, animations: {
                self.bottomButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 30)
            })
            
        }
    }
    
    @objc func keyboardMoveDown(_ notification: NSNotification) {
        self.bottomButton.transform = .identity
    }
}

extension ViewController {
    private func configUI() {
        textField.placeholder = "입력해주세요"
        textField.delegate = self
        textField.textAlignment = .center
        
        bottomButton.backgroundColor = .yellow
        bottomButton.setTitle("다음으로?", for: .normal)
        bottomButton.setTitleColor(.black, for: .normal)
        bottomButton.layer.cornerRadius = 12
    }
    
    private func setLayout() {
        view.addSubview(textField)
        view.addSubview(bottomButton)
        
        textField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
        }
        
        bottomButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(56)
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
