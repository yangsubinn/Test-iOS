//
//  ViewController.swift
//  MVVM-RxSwift
//
//  Created by 양수빈 on 2022/09/24.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        setNoti()
        setDelegate()
        setButtonState(false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        removeNoti()
    }

    // MARK: - Custom Methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
            self.view.endEditing(true)
        }
    
    private func setDelegate() {
        emailTextField.delegate = self
        pwTextField.delegate = self
    }
    
    private func configUI() {
        emailTextField.placeholder = "email plz"
        pwTextField.placeholder = "password plz"
        
        loginButton.titleLabel?.textColor = .white
        loginButton.titleLabel?.text = "LOGIN"
    }
    
    private func setButtonState(_ enable: Bool) {
        if enable {
            loginButton.backgroundColor = .orange
            loginButton.isEnabled = true
        } else {
            loginButton.backgroundColor = .darkGray
            loginButton.isEnabled = false
        }
    }
    
    private func setNoti() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardMoveUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardMoveDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeNoti() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - @objc
    
    @objc func keyboardMoveUp(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print(keyboardSize)
            UIView.animate(withDuration: 0.3, animations: {
                self.loginButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 30)
            })
            
        }
    }
    
    @objc func keyboardMoveDown(_ notification: NSNotification) {
        self.loginButton.transform = .identity
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
