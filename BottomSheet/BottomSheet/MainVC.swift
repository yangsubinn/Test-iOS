//
//  MainVC.swift
//  BottomSheet
//
//  Created by 양수빈 on 2022/02/06.
//

import UIKit

class MainVC: UIViewController {
    
    // MARK: - Properties
    let titleLabel = UILabel()

    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        view.backgroundColor = .orange
        titleLabel.text = "바텀시트를 보여볼게 하나둘셋"
        titleLabel.font = .systemFont(ofSize: 20)
    }
    
    private func setLayout() {
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
