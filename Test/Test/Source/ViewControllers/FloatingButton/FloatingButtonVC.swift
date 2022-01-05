//
//  FloatingButtonVC.swift
//  Test
//
//  Created by 양수빈 on 2022/01/05.
//

import UIKit

import JJFloatingActionButton

class FloatingButtonVC: UIViewController {
    
    let actionButton = JJFloatingActionButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        setButtonUI()
    }
    
    func setLayout() {
        view.addSubview(actionButton)
        
        actionButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(30)
        }
    }
    
    func setButtonUI() {
//        actionButton.handleSingleActionDirectly = false
//        actionButton.buttonDiameter = 65
//        actionButton.overlayView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        actionButton.buttonImage = UIImage(systemName: "moon")
        actionButton.buttonColor = .purple
        actionButton.buttonImageColor = .white
        actionButton.buttonImageSize = CGSize(width: 24, height: 24)

//        actionButton.buttonAnimationConfiguration = .transition(toImage: UIImage(sys: "X"))
//        actionButton.itemAnimationConfiguration = .slideIn(withInterItemSpacing: 14)

//        actionButton.layer.shadowColor = UIColor.black.cgColor
//        actionButton.layer.shadowOffset = CGSize(width: 0, height: 1)
//        actionButton.layer.shadowOpacity = Float(0.4)
//        actionButton.layer.shadowRadius = CGFloat(2)

        actionButton.itemSizeRatio = CGFloat(1)
//        actionButton.configureDefaultItem { item in
//            item.titlePosition = .trailing
//
//            item.titleLabel.font = .boldSystemFont(ofSize: UIFont.systemFontSize)
//            item.titleLabel.textColor = .white
//            item.buttonColor = .white
//            item.buttonImageColor = .red
//
//            item.layer.shadowColor = UIColor.black.cgColor
//            item.layer.shadowOffset = CGSize(width: 0, height: 1)
//            item.layer.shadowOpacity = Float(0.4)
//            item.layer.shadowRadius = CGFloat(2)
//        }

//        actionButton.addItem(title: "Balloon", image: UIImage(named: "Baloon")) { item in
//            // Do something
//        }

//        let item = actionButton.addItem()
//        item.titleLabel.text = "Owl"
//        item.imageView.image = UIImage(named: "Owl")
//        item.buttonColor = .black
//        item.buttonImageColor = .white
//        item.buttonImage?.size = CGSize(width: 30, height: 30)
//        item.action = { item in
//            // Do something
//        }
        
        
        actionButton.addItem(title: "첫번째", image: UIImage(systemName: "house")) { _ in
            print("첫번째 눌림")
        }
        
        actionButton.addItem(title: "두번째", image: UIImage(systemName: "house.fill")) { _ in
            print("두번째 눌림")
        }
    }
}
