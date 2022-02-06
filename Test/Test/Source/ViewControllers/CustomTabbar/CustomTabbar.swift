//
//  CustomTabbar.swift
//  Test
//
//  Created by 양수빈 on 2022/01/31.
//

import UIKit

import SnapKit

class CustomTabbar: UIViewController {
    
    // MARK: - Properties
    let tabView = UIView()
    let tabStackView = UIStackView()
    let feedButton = UIButton()
    let homeButton = UIButton()
    let storageButton = UIButton()
    
    var selectedIndex: Int = 0
    var previousIndex: Int = 0
    var buttons = [UIButton]()
    var viewControllers = [UIViewController]()
    
    static let feedVC = UIStoryboard(name: "CustomTabbar", bundle: nil).instantiateViewController(withIdentifier: "FeedVC")
    static let homeVC = UIStoryboard(name: "CustomTabbar", bundle: nil).instantiateViewController(withIdentifier: "MainHomeVC")
    static let storageVC = UIStoryboard(name: "CustomTabbar", bundle: nil).instantiateViewController(withIdentifier: "StorageVC")
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
        setUI()
        setTabbar()
        setStackView()
        setAddTarget()
    }
    
    // MARK: - Custom Method
    private func setTabbar() {
        viewControllers.append(CustomTabbar.feedVC)
        viewControllers.append(CustomTabbar.homeVC)
        viewControllers.append(CustomTabbar.storageVC)
        
        buttons.append(feedButton)
        buttons.append(homeButton)
        buttons.append(storageButton)
        
        buttons[selectedIndex].isSelected = true
    }
    
    private func setAddTarget() {
        feedButton.addTarget(self, action: #selector(tabChanged(sender:)), for: .touchUpInside)
        homeButton.addTarget(self, action: #selector(tabChanged(sender:)), for: .touchUpInside)
        storageButton.addTarget(self, action: #selector(tabChanged(sender:)), for: .touchUpInside)
    }
    
    private func setLayout() {
        view.addSubview(tabView)
        
        tabView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(84)
        }
        
        tabView.addSubview(tabStackView)
        
        tabStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(13)
        }
    }
    
    private func setStackView() {
        tabStackView.axis = .horizontal
        tabStackView.alignment = .fill
        tabStackView.distribution = .equalSpacing
        tabStackView.spacing = 44
        tabStackView.addArrangedSubview(feedButton)
        tabStackView.addArrangedSubview(homeButton)
        tabStackView.addArrangedSubview(storageButton)
        
        feedButton.snp.makeConstraints { make in
            make.width.height.equalTo(48)
        }
        
        homeButton.snp.makeConstraints { make in
            make.width.height.equalTo(48)
        }
        
        storageButton.snp.makeConstraints { make in
            make.width.height.equalTo(48)
        }
    }
    
    private func setUI() {
        view.backgroundColor = .white
        
        feedButton.tag = 0
        homeButton.tag = 1
        storageButton.tag = 2
        
        feedButton.setImage(UIImage(systemName: "heart"), for: .normal)
        homeButton.setImage(UIImage(systemName: "house"), for: .normal)
        storageButton.setImage(UIImage(systemName: "tray"), for: .normal)
        
        feedButton.tintColor = .gray
        homeButton.tintColor = .systemPink
        storageButton.tintColor = .gray
    }
    
    // MARK: - @objc
    @objc
    func tabChanged(sender: UIButton) {
        previousIndex = selectedIndex
        selectedIndex = sender.tag
        
        buttons[previousIndex].isSelected = false
        let previousVC = viewControllers[previousIndex]
        
        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()
        
        buttons.forEach { $0.isSelected = false }
        sender.isSelected = true
        
        switch selectedIndex {
        case 0 :
            feedButton.tintColor = .systemPink
            homeButton.tintColor = .gray
            storageButton.tintColor = .gray
        case 1:
            feedButton.tintColor = .gray
            homeButton.tintColor = .systemPink
            storageButton.tintColor = .gray
        case 2:
            feedButton.tintColor = .gray
            homeButton.tintColor = .gray
            storageButton.tintColor = .systemPink
        default:
            feedButton.tintColor = .gray
            homeButton.tintColor = .gray
            storageButton.tintColor = .gray
        }
        
        let vc = viewControllers[selectedIndex]
        vc.view.frame = UIApplication.shared.windows[0].frame
        vc.didMove(toParent: self)
        self.addChild(vc)
        self.view.addSubview(vc.view)
        
        self.view.bringSubviewToFront(tabView)
    }
}

