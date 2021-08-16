//
//  SecondViewController.swift
//  Test
//
//  Created by 양수빈 on 2021/08/16.
//

import UIKit
import SnapKit

class SecondViewController: UIViewController {
    
    let titleLabel = UILabel()
    let subLabel = UILabel()
    let goButton = UIButton()
    let backButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        setupLayout()
    }
    
    func configUI() {
        titleLabel.text = "SecondViewController"
        titleLabel.textAlignment = .center
        
        subLabel.text = "Codebase로 UI 구성"
        subLabel.textAlignment = .center
        subLabel.font = .systemFont(ofSize: 12)
        subLabel.textColor = .lightGray
        
        goButton.backgroundColor = .red
        backButton.backgroundColor = .blue
        
        goButton.setTitle("GO", for: .normal)
        backButton.setTitle("BACK", for: .normal)
    }
    
    func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(subLabel)
        view.addSubview(goButton)
        view.addSubview(backButton)
        
        // AutoLayout Programmatically
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        subLabel.translatesAutoresizingMaskIntoConstraints = false
//        goButton.translatesAutoresizingMaskIntoConstraints = false
//        backButton.translatesAutoresizingMaskIntoConstraints = false
//
//        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
//        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        titleLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
//
//        subLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        subLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
//        subLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        subLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
//
//        goButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        goButton.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 50).isActive = true
//        goButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        goButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
//
//        backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        backButton.topAnchor.constraint(equalTo: goButton.bottomAnchor, constant: 20).isActive = true
//        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        backButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        // Snapkit
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(200)
            make.width.equalTo(300)
            make.height.equalTo(30)
        }
        
        subLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom)
            make.width.equalTo(300)
            make.height.equalTo(30)
        }
        
        goButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(subLabel.snp.bottom).offset(50)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        backButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(goButton.snp.bottom).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
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
