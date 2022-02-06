//
//  ViewController.swift
//  BottomSheet
//
//  Created by 양수빈 on 2022/02/06.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    private let tapButton = UIButton()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setAddTarget()
    }

    // MARK: - Custom Method
    private func setUI() {
        tapButton.setTitle("Bottom Sheet", for: .normal)
        tapButton.setTitleColor(.orange, for: .normal)
    }
    
    private func setLayout() {
        view.addSubview(tapButton)
        
        tapButton.translatesAutoresizingMaskIntoConstraints = false
        
        tapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tapButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setAddTarget() {
        tapButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    // MARK: - @objc
    @objc
    func buttonTapped() {
        print("버튼 눌림")
        guard let bottomSheet = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BottomSheetViewController") as? BottomSheetViewController else { return }
        bottomSheet.modalPresentationStyle = .overFullScreen
        self.present(bottomSheet, animated: false, completion: nil)
    }
}

