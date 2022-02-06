//
//  BottomSheetViewController.swift
//  BottomSheet
//
//  Created by 양수빈 on 2022/02/06.
//

import UIKit

class BottomSheetViewController: UIViewController {
    
    // MARK: - Properties
    
    private let dimmerView = UIView()
    private let bottomSheetView = UIView()
    private var bottomSheetViewTopConstraint: NSLayoutConstraint!
    private var defaultHeight: CGFloat = 300
    
    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setTapGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showBottomSheet()
    }
    
    // MARK: - Custom Method
    private func setUI() {
        self.view.backgroundColor = .clear
        dimmerView.backgroundColor = .darkGray.withAlphaComponent(0.7)
        dimmerView.alpha = 0.0
        
        bottomSheetView.backgroundColor = .white
        bottomSheetView.layer.cornerRadius = 10
        bottomSheetView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bottomSheetView.clipsToBounds = true
    }
    
    private func setLayout() {
        view.addSubview(dimmerView)
        view.addSubview(bottomSheetView)
        
        dimmerView.translatesAutoresizingMaskIntoConstraints = false
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        
        dimmerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dimmerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        dimmerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        dimmerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
        bottomSheetViewTopConstraint = bottomSheetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant)
        NSLayoutConstraint.activate([
            bottomSheetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomSheetViewTopConstraint,
        ])
    }
    
    private func showBottomSheet() {
        let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding: CGFloat = view.safeAreaInsets.bottom
        
        bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - defaultHeight
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmerView.alpha = 0.7
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func setTapGesture() {
        let dimmerTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
        dimmerView.addGestureRecognizer(dimmerTap)
        dimmerView.isUserInteractionEnabled = true
    }
    
    private func hideBottomSheetAndGoBack() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmerView.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    // MARK: - @objc
    @objc
    private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheetAndGoBack()
    }
}
