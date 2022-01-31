//
//  NotiVC.swift
//  Test
//
//  Created by 양수빈 on 2021/11/02.
//

import UIKit

import SnapKit
import Then

class NotiVC: UIViewController {
    /**
         notiButton을 누르면 willChangeLabel이 바뀌고,
         바뀐 willChangedLabel을 notificationCenter에서 잡아서
         resultLabel을 변경하는 로직
     */
    
    // MARK: - Properties
    var resultLabel = UILabel().then {
        $0.textColor = .orange
        $0.text = "최종결과가 들어올 라벨입니당"
        $0.textAlignment = .center
    }
    
    var willChangeLabel = UILabel().then {
        $0.textColor = .purple
        $0.text = "버튼을 누르면 글이 들어올거에여"
        $0.textAlignment = .center
    }
    
    let notiButton = UIButton().then {
        $0.setTitle("눌러보세여", for: .normal)
        $0.backgroundColor = .purple
        $0.layer.cornerRadius = 12
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        setupAction()
    }
    
    // MARK: - Custom Method
    func setupLayout() {
        view.addSubview(resultLabel)
        view.addSubview(willChangeLabel)
        view.addSubview(notiButton)
        
        notiButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(300)
            $0.width.equalTo(100)
            $0.height.equalTo(40)
        }
        
        willChangeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(notiButton.snp.bottom).offset(40)
        }
        
        resultLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(willChangeLabel.snp.bottom).offset(60)
        }
    }
    
    func setupAction() {
        /// addTarget
        notiButton.addTarget(self, action: #selector(touchUpNotiButton), for: .touchUpInside)
        
        /// Notification
        /// NotificationCenter.defaul.addObserver : 설정한 name의 noti가 오면 #selector에 해당하는 함수 실행
        /// seupResultLabel이라는 이름의 notification을 감지하면 changeResult라는 메소드를 실행
        NotificationCenter.default.addObserver(self, selector: #selector(changeResult), name: Notification.Name("setupResultLabel"), object: nil)
    }
    
    // MARK: - @objc
    @objc func touchUpNotiButton() {
        willChangeLabel.text = "값이 바뀌었쥬?"
        
        /// if 조건에 해당하면 안의 notificationCenter에서 observer에게 setupResultLabel이라는 이름이 noti를 보냄
        if willChangeLabel.text != "버튼을 누르면 글이 들어올거에여" {
            /// NotificationCenter.default.post : 설정한 name의 noti를 observer에게 보냄
            NotificationCenter.default.post(name: Notification.Name("setupResultLabel"), object: nil)
        }
    }
    
    /// notificationCenter을 통해 실행되는 메소드
    @objc func changeResult() {
        resultLabel.text = "RESULT 축하함다"
    }
}
