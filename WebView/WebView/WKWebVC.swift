//
//  WKWebVC.swift
//  WebView
//
//  Created by 양수빈 on 2022/10/11.
//

import UIKit
import WebKit

class WKWebVC: UIViewController {
    
    static let identifier = "WKWebVC"
    
    private let webView = WKWebView(frame: .zero)
    private let toolBar = UIToolbar()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setWebView()
        self.setToolBar()
        self.setLayout()
    }
    
    private func setWebView() {
//        self.view = webView // view 자체를 webView로 덮고 싶은 경우
        let url = URL(string: "https://nosy-repair-8a6.notion.site/Web-views-b0673c13e9564ecfbe880481ab74454b")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    private func setToolBar() {
        self.toolBar.backgroundColor = .white
        
        let backButtonItem = UIBarButtonItem(title: "뒤로 가기", style: .plain, target: self, action: #selector(backToView))
        let forwardButtonItem = UIBarButtonItem(title: "앞으로 가기", style: .plain, target: self, action: #selector(forwardToView))
        let refreshButtonItem = UIBarButtonItem(title: "새로 고침", style: .plain, target: self, action: #selector(refreshView))
        
        let items = [backButtonItem, forwardButtonItem, refreshButtonItem]
        self.toolBar.setItems(items, animated: true)
    }
    
    private func setLayout() {
        self.view.addSubview(webView)
        self.view.addSubview(toolBar)
        
        toolBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        webView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(toolBar.snp.top)
        }
    }
    
    @objc
    private func backToView() {
        if webView.canGoBack {
            webView.goBack()
        } else {
            print("뒤로 못감")
        }
    }
    
    @objc
    private func forwardToView() {
        if webView.canGoForward {
            webView.goForward()
        } else {
            print("앞으로 갈게 없음")
        }
    }
    
    @objc
    private func refreshView() {
        webView.reload()
    }
}
