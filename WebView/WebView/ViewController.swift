//
//  ViewController.swift
//  WebView
//
//  Created by 양수빈 on 2022/10/11.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let stackView = UIStackView()
    private let webViewButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        self.setStackView()
        self.setLayout()
        self.setAddTarget()
    }
    
    private func configUI() {
        webViewButton.setTitle("WKWebView", for: .normal)
        webViewButton.setTitleColor(.blue, for: .normal)
    }
    
    private func setStackView() {
        stackView.axis = .vertical
    }

    private func setLayout() {
        self.view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        stackView.addArrangedSubview(webViewButton)
    }

    private func setAddTarget() {
        webViewButton.addTarget(self, action: #selector(presentWKWebVC), for: .touchUpInside)
    }
    
    @objc
    private func presentWKWebVC() {
        guard let WKWebVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WKWebVC") as? WKWebVC else { return }
        
        self.present(WKWebVC, animated: true)
    }
}

