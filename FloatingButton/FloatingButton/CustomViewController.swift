//
//  CustomViewController.swift
//  FloatingButton
//
//  Created by 양수빈 on 2022/02/07.
//

import UIKit

import SnapKit

class CustomViewController: UIViewController {

    // MARK: - Properties
    private let contentLabel = UILabel()
    private let selectedLabel = UILabel()
    private let dimmerView = UIView()
    private let floatingButton = UIButton()
    private let firstButton = UIButton()
    private let secondButton = UIButton()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setAddTarget()
    }
    
    // MARK: - Custom Method
    private func setUI() {
        view.backgroundColor = .systemIndigo
        
        dimmerView.backgroundColor = .black.withAlphaComponent(0.8)
        dimmerView.alpha = 0.0
        
        contentLabel.text = "CustomViewController"
        selectedLabel.text = "-"
        
        floatingButton.backgroundColor = .white
        floatingButton.setImage(UIImage(systemName: "plus"), for: .normal)
        floatingButton.tintColor = .black
        floatingButton.layer.cornerRadius = 30
        floatingButton.layer.shadowColor = UIColor.black.cgColor
        floatingButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        floatingButton.layer.shadowOpacity = 0.4
        floatingButton.layer.shadowRadius = 5
        floatingButton.layer.shadowPath = nil
        
        firstButton.backgroundColor = .white
        firstButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        firstButton.tintColor = .black
        firstButton.layer.cornerRadius = 26
        
        secondButton.backgroundColor = .white
        secondButton.setImage(UIImage(systemName: "heart"), for: .normal)
        secondButton.tintColor = .black
        secondButton.layer.cornerRadius = 26
    }
    
    private func setLayout() {
        view.addSubview(contentLabel)
        view.addSubview(selectedLabel)
        view.addSubview(dimmerView)
        view.addSubview(firstButton)
        view.addSubview(secondButton)
        view.addSubview(floatingButton)
        
        contentLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        selectedLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentLabel.snp.centerX)
            make.top.equalTo(contentLabel.snp.bottom).offset(16)
        }
        
        dimmerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        firstButton.snp.makeConstraints { make in
            make.center.equalTo(floatingButton.snp.center)
            make.width.height.equalTo(50)
        }
        
        secondButton.snp.makeConstraints { make in
            make.center.equalTo(floatingButton.snp.center)
            make.width.height.equalTo(50)
        }
        
        floatingButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(40)
            make.width.height.equalTo(60)
        }
    }
    
    private func setAddTarget() {
        floatingButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        firstButton.addTarget(self, action: #selector(firstButtonTapped), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(secondButtonTapped), for: .touchUpInside)
    }
    
    private func hiddenFloatingAction() {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
            let frame = CGAffineTransform(translationX: 0, y: 0)
            let rotate = CGAffineTransform(rotationAngle: 0.0)
            
            self.dimmerView.alpha = 0.0
            self.floatingButton.backgroundColor = .white
            self.floatingButton.tintColor = .black
            self.floatingButton.layer.shadowColor = UIColor.black.cgColor
            self.floatingButton.transform = rotate
            self.firstButton.transform = frame
            self.secondButton.transform = frame
            
        }, completion: { _ in
            self.floatingButton.isSelected = false
        })
    }
    
    private func showFloatingAction() {
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
            let firstFrame = CGAffineTransform(translationX: 0, y: -(80+50+16))
            let secondFrame = CGAffineTransform(translationX: 0, y: -(80))
            let rotate = CGAffineTransform(rotationAngle: -40.0)
            
            self.dimmerView.alpha = 1.0
            self.floatingButton.backgroundColor = .black
            self.floatingButton.tintColor = .white
            self.floatingButton.layer.shadowColor = UIColor.white.cgColor
            self.floatingButton.transform = rotate
            self.firstButton.transform = firstFrame
            self.secondButton.transform = secondFrame
            
        }, completion: { _ in
            self.floatingButton.isSelected = true
        })
    }
    
    // MARK: - @objc
    @objc
    func buttonClicked() {
        if floatingButton.isSelected {
            hiddenFloatingAction()
        } else {
            showFloatingAction()
        }
    }
    
    @objc
    func firstButtonTapped() {
        selectedLabel.text = "firstButton tapped"
        hiddenFloatingAction()
    }
    
    @objc
    func secondButtonTapped() {
        selectedLabel.text = "secondButton tapped"
        hiddenFloatingAction()
    }
}
