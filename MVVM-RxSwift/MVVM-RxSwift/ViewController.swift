//
//  ViewController.swift
//  MVVM-RxSwift
//
//  Created by 양수빈 on 2022/09/24.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Properties
    
    private var loginButtonClicked = PublishSubject<UserData>()
    private var emailEditEventFinished = PublishSubject<String?>()
    private var pwEditEvendFinished = PublishSubject<String?>()
    private var disposeBag = DisposeBag()
    var viewModel = TestViewModel()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        addTargets()
        setNoti()
        setDelegate()
        setButtonState(false)
        bindViewModels()
        setButtonAction()
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
        loginButton.titleLabel?.text = "LOGIN"
    }
    
    private func addTargets() {
        self.emailTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        self.pwTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
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
    
    private func setButtonAction() {
        self.loginButton.rx.tap
            .bind {
                let userData = UserData(
                    email: self.emailTextField.text ?? "-",
                    password: self.pwTextField.text ?? "--")
                self.loginButtonClicked.onNext(userData)
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - @objc
    
    @objc func keyboardMoveUp(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.3, animations: {
                self.loginButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 30)
            })
            
        }
    }
    
    @objc func keyboardMoveDown(_ notification: NSNotification) {
        self.loginButton.transform = .identity
    }
    
    @objc func textFieldDidChange(_ sender: Any?) {
        self.emailEditEventFinished.onNext(self.emailTextField.text)
        self.pwEditEvendFinished.onNext(self.pwTextField.text)
    }
}

extension ViewController {
    private func bindViewModels() {
        let input = TestViewModel.Input(
            email: emailEditEventFinished.asObservable(),
            password: pwEditEvendFinished.asObservable(),
            tapLogIn: loginButtonClicked)
        let output = self.viewModel.transform(from: input, disposeBag: disposeBag)
        
        output.enableLogInButton
            .subscribe(onNext: { [weak self] state in
                guard let self = self else { return }
                self.setButtonState(state)
            })
            .disposed(by: disposeBag)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
