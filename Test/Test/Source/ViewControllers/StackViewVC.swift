//
//  StackViewVC.swift
//  Test
//
//  Created by 양수빈 on 2021/09/15.
//

import UIKit

import SnapKit

class StackViewVC: UIViewController {

    @IBOutlet weak var storyboardStackLabel: UILabel!
    
    let stackView = UIStackView()
    let leftButton = UIButton()
    let centerButton = UIButton()
    let rightButton = UIButton()
    let codeStackLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupStackView()
        setLabel()
    }
    
    @IBAction func clickFirstButton(_ sender: UIButton) {
        storyboardStackLabel.text = "Button1 clicked"
    }
    
    @IBAction func clickSecondButton(_ sender: UIButton) {
        storyboardStackLabel.text = "Button2 clicked"
    }
    
    @IBAction func clickThirdButton(_ sender: UIButton) {
        storyboardStackLabel.text = "Button3 clicked"
    }
    
    func setupStackView() {
        view.addSubview(stackView)
        
        stackView.backgroundColor = .darkGray
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(leftButton)
        stackView.addArrangedSubview(centerButton)
        stackView.addArrangedSubview(rightButton)
        
        leftButton.setTitle("left", for: .normal)
        centerButton.setTitle("center", for: .normal)
        rightButton.setTitle("right", for: .normal)
        
        leftButton.backgroundColor = .purple
        centerButton.backgroundColor = .systemYellow
        rightButton.backgroundColor = .systemPink
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(storyboardStackLabel.snp.bottom).offset(100)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    func setLabel() {
        view.addSubview(codeStackLabel)
        
        codeStackLabel.text = "Label"
        
        codeStackLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(stackView.snp.bottom).offset(50)
        }
    }

}
