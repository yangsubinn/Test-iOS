//
//  NextViewController.swift
//  ARC
//
//  Created by 양수빈 on 2023/02/15.
//

import UIKit

class NextViewController: UIViewController {
    
    var viewModel: NextViewModel!
    private var moduleFactory = ModuleFactory.shared
    
    private let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    deinit {
        print("NextViewController deinit")
    }
    
    private func setUI() {
        view.backgroundColor = .white
        titleLabel.text = "NextViewController"
        
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
