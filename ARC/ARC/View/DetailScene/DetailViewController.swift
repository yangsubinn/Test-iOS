//
//  DetailViewController.swift
//  ARC
//
//  Created by 양수빈 on 2023/02/15.
//

import UIKit

class DetailViewController: UIViewController {

    var viewModel: DetailViewModel!
    private var moduleFactory = ModuleFactory.shared
    
    private let titleLabel = UILabel()
    
    override func loadView() {
        super.loadView()
        print("DetailViewController - loadView")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    deinit {
        print("DetailViewController -  deinit")
    }
    
    private func setUI() {
        view.backgroundColor = .white
        titleLabel.text = "DetailViewController"
        
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
