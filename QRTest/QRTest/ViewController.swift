//
//  ViewController.swift
//  QRTest
//
//  Created by 양수빈 on 2023/01/10.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let qrView = QRCodeView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        qrView.getnerateCode("https://github.com/yangsubinn", backgroundColor: .systemPink)
    }

    private func setLayout() {
        self.view.addSubview(qrView)
        
        qrView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(300)
        }
    }
}

