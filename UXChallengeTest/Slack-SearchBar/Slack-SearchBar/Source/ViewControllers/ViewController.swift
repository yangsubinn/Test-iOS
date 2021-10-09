//
//  ViewController.swift
//  Slack-SearchBar
//
//  Created by 양수빈 on 2021/10/10.
//

import UIKit

import SnapKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    // MARK: - Properties
    let searchBar = UISearchBar()
    let testLabel = UILabel()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        setupLayout()
    }

    // MARK: - Custom Method
    func configUI() {
        searchBar.delegate = self
        
//        searchBar.placeholder = "메시지 및 파일 검색"
        UISearchBar.appearance().tintColor = .purple
        UISearchBar.appearance().placeholder = "메시지 및 파일 검색"
        
        testLabel.text = "까꿍"
        testLabel.isHidden = true
        
        
        
        hideKeyboardWhenTappedAround()
    }
    
    func setupLayout() {
        view.addSubview(searchBar)
        view.addSubview(testLabel)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        testLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        testLabel.isHidden = false
        searchBar.setShowsCancelButton(true, animated: true)
        let cancelButton = searchBar.value(forKey: "cancelButton") as! UIButton
        cancelButton.setTitle("취소", for: .normal)
        
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.hideKeyboard()
        searchBar.setShowsCancelButton(false, animated: true)
        testLabel.text = "서치바 디드 엔드 에디팅이란 말이여"
        testLabel.isHidden = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        testLabel.isHidden = true
        self.hideKeyboard()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.hideKeyboard()
        testLabel.isHidden = true
    }
}

// MARK: - extension
extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
