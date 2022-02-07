//
//  ViewController.swift
//  FloatingButton
//
//  Created by 양수빈 on 2022/02/07.
//

import UIKit

import SnapKit
import JJFloatingActionButton

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    let actionButton = JJFloatingActionButton()

    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setButtonUI()
    }
    
    // MARK: - Custom Method
    
    func setLayout() {
        view.addSubview(actionButton)
        
        actionButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(30)
        }
    }
    
    func setButtonUI() {
        actionButton.buttonImage = UIImage(systemName: "moon")
        actionButton.buttonColor = .purple
        actionButton.buttonImageColor = .white
        actionButton.buttonImageSize = CGSize(width: 24, height: 24)
        actionButton.itemSizeRatio = CGFloat(1)
        
        actionButton.addItem(title: "첫번째", image: UIImage(systemName: "house")) { _ in
            print("첫번째 눌림")
        }
        
        actionButton.addItem(title: "두번째", image: UIImage(systemName: "house.fill")) { _ in
            print("두번째 눌림")
        }
    }
}

