//
//  KeyboardVC.swift
//  Test
//
//  Created by 양수빈 on 2021/08/17.
//

import UIKit

class KeyboardVC: UIViewController, UITextFieldDelegate {
    
    let textField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(textField)

        textField.delegate = self
        textField.borderStyle = .roundedRect
        textField.placeholder = "뭐요머야아아아허ㅑ너ㅐㅈ먀ㅓㅐ"

        textField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    // return키 눌렀을 때 키보드가 내려가게 하려면,
    // UITextFieldDelegate 채택하고
    // textField.delegate = self
    // textFieldShouleReturn 함수 추가
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

    // 화면 여백 터치했을 때 키보드 내려가게 하려면,
    // touchesBegan 함수 추가
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
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
