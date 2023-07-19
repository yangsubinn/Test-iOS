//
//  ViewController.swift
//  SocialLogin
//
//  Created by 양수빈 on 2022/01/28.
//

import UIKit
import KakaoSDKUser

class ViewController: UIViewController {

    @IBOutlet weak var kakaoLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func kakaoLoginButtonTapped(_ sender: Any) {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error {
                    print(error)
                } else {
                    print("loginWithKakaoTalk success 🎉")
                    _ = oauthToken
                    print("🧃 token: \(oauthToken)")
                }
            }
        }
    }
}

