//
//  ViewController.swift
//  WebView
//
//  Created by 양수빈 on 2022/10/11.
//

import UIKit
import SnapKit
import SafariServices

class ViewController: UIViewController {
    
    private let stackView = UIStackView()
    private let webViewButton = UIButton()
    private let safariButton = UIButton()
    private let safariVCButton = UIButton()

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
        
        safariButton.setTitle("SafariApp", for: .normal)
        safariButton.setTitleColor(.blue, for: .normal)
        
        safariVCButton.setTitle("SafariViewController", for: .normal)
        safariVCButton.setTitleColor(.blue, for: .normal)
    }
    
    private func setStackView() {
        stackView.axis = .vertical
        stackView.spacing = 20
    }

    private func setLayout() {
        self.view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        stackView.addArrangedSubview(webViewButton)
        stackView.addArrangedSubview(safariButton)
        stackView.addArrangedSubview(safariVCButton)
    }

    private func setAddTarget() {
        webViewButton.addTarget(self, action: #selector(presentWKWebVC), for: .touchUpInside)
        safariButton.addTarget(self, action: #selector(moveToSafari), for: .touchUpInside)
        safariVCButton.addTarget(self, action: #selector(openSafariVC), for: .touchUpInside)
    }
    
    @objc
    private func presentWKWebVC() {
        guard let WKWebVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WKWebVC") as? WKWebVC else { return }
        
        self.present(WKWebVC, animated: true)
    }
    
    @objc
    private func moveToSafari() {
        let url = URL(string: "https://nosy-repair-8a6.notion.site/Web-views-b0673c13e9564ecfbe880481ab74454b")
        UIApplication.shared.open(url!)
    }
    
    @objc
    private func openSafariVC() {
        let url = URL(string: "https://nosy-repair-8a6.notion.site/Web-views-b0673c13e9564ecfbe880481ab74454b")
        let safariVC = SFSafariViewController(url: url!)
        present(safariVC, animated: true)
    }
}

