//
//  ViewController.swift
//  ARC
//
//  Created by 양수빈 on 2023/02/15.
//

import UIKit

class ViewController: UIViewController {
    
    private var moduleFactory = ModuleFactory.shared
    private let detailButton = UIButton()
    private let nextButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    private func setUI() {
        detailButton.setTitle("상세로", for: .normal)
        detailButton.setTitleColor(.systemBlue, for: .normal)
        
        nextButton.setTitle("다음으로", for: .normal)
        nextButton.setTitleColor(.systemBlue, for: .normal)
        
        view.addSubview(detailButton)
        view.addSubview(nextButton)
        
        detailButton.translatesAutoresizingMaskIntoConstraints = false
        detailButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        detailButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100).isActive = true
        
        detailButton.addTarget(self, action: #selector(tappedDetailButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(tappedNextButton), for: .touchUpInside)
    }

    @objc
    private func tappedDetailButton() {
        let nextVC = moduleFactory.makeDetailVC()
//        self.present(nextVC, animated: true)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc
    private func tappedNextButton() {
        let nextVC = moduleFactory.makeNextVC()
        self.present(nextVC, animated: true)
    }
}

