//
//  BottomSheetViewController.swift
//  BottomSheet
//
//  Created by 양수빈 on 2022/02/06.
//

import UIKit

class BottomSheetViewController: UIViewController {
    
    enum BottomSheetViewState {
        case expanded
        case normal
    }
    
    // MARK: - Properties
    
    private let contentViewController: UIViewController
    private let dimmerView = UIView()
    private let bottomSheetView = UIView()
    private var bottomSheetViewTopConstraint: NSLayoutConstraint!
    private var defaultHeight: CGFloat = 300
    
    // Bottom Sheet과 safe Area Top 사이의 최소값을 지정하기 위한 프로퍼티
    // 기본값은 30으로 지정
    var bottomSheetPanMinTopConstant: CGFloat = 30.0
    // 드래그 하기 전에 Bottom Sheet의 top Constraint value를 저장하기 위한 프로퍼티
    private lazy var bottomSheetPanStartingTopConstant: CGFloat = bottomSheetPanMinTopConstant
    
    // MARK: - Life Cycles
    
    // 이니셜라이저 구현
    init(contentViewController: UIViewController) {
        self.contentViewController = contentViewController
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setTapGesture()
        setPanGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showBottomSheet()
    }
    
    // MARK: - Custom Method
    private func setUI() {
        self.view.backgroundColor = .clear
        dimmerView.backgroundColor = .darkGray.withAlphaComponent(0.7)
        addChild(contentViewController)
        bottomSheetView.addSubview(contentViewController.view)
        contentViewController.didMove(toParent: self)
        bottomSheetView.clipsToBounds = true
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
        contentViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        NSLayoutConstraint.activate([
            contentViewController.view.topAnchor.constraint(equalTo: bottomSheetView.topAnchor),
            contentViewController.view.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor),
            contentViewController.view.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor),
            contentViewController.view.bottomAnchor.constraint(equalTo: bottomSheetView.bottomAnchor)
        ])
    }
    
    private func showBottomSheet(atState: BottomSheetViewState = .normal) {
        if atState == .normal {
            let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
            let bottomPadding: CGFloat = view.safeAreaInsets.bottom
            bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - defaultHeight
        } else {
            bottomSheetViewTopConstraint.constant = bottomSheetPanMinTopConstant
        }
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
//            self.dimmerView.alpha = 0.7
            self.dimmerView.alpha = self.dimAlphaWithBottomSheetTopConstraint(value: self.bottomSheetViewTopConstraint.constant)
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func setTapGesture() {
        let dimmerTap = UITapGestureRecognizer(target: self, action: #selector(dimmerViewTapped(_:)))
        dimmerView.addGestureRecognizer(dimmerTap)
        dimmerView.isUserInteractionEnabled = true
    }
    
    private func setPanGesture() {
        // Pan Gesture Recognizer를 view controller의 view에 추가하기 위한 코드
        let viewPan = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
        
        // 기본적으로 iOS는 터치가 드래그하였을 때 딜레이가 발생함
        // 우리는 드래그 제스쳐가 바로 발생하길 원하기 때문에 딜레이가 없도록 아래와 같이 설정
        viewPan.delaysTouchesBegan = false
        viewPan.delaysTouchesEnded = false
        view.addGestureRecognizer(viewPan)
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
    
    //주어진 CGFloat 배열의 값 중 number로 주어진 값과 가까운 값을 찾아내는 메소드
    private func nearest(to number: CGFloat, inValues values: [CGFloat]) -> CGFloat {
        guard let nearestVal = values.min(by: { abs(number - $0) < abs(number - $1) })
        else { return number }
        return nearestVal
    }
    
    private func dimAlphaWithBottomSheetTopConstraint(value: CGFloat) -> CGFloat {
        let fullDimAlpha: CGFloat = 0.7
        
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        
        // bottom sheet의 top constraint 값이 fullDimPosition과 같으면
        // dimmer view의 alpha 값이 0.7이 되도록 합니다
        let fullDimPosition = (safeAreaHeight + bottomPadding - defaultHeight) / 2
        
        // bottom sheet의 top constraint 값이 noDimPosition과 같으면
        // dimmer view의 alpha 값이 0.0이 되도록 합니다
        let noDimPosition = safeAreaHeight + bottomPadding
        
        // Bottom Sheet의 top constraint 값이 fullDimPosition보다 작으면
        // 배경색이 가장 진해진 상태로 지정해줍니다.
        if value < fullDimPosition {
            return fullDimAlpha
        }
        
        // Bottom Sheet의 top constraint 값이 noDimPosition보다 크면
        // 배경색이 투명한 상태로 지정해줍니다.
        if value > noDimPosition {
            return 0.0
        }
        
        // 그 외의 경우 top constraint 값에 따라 0.0과 0.7 사이의 alpha 값이 Return되도록 합니다
        return fullDimAlpha * (1 - ((value - fullDimPosition) / (noDimPosition - fullDimPosition)))
    }
    
    // MARK: - @objc
    /// dimmerView를 탭했을때 화면 꺼지도록
    @objc
    private func dimmerViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheetAndGoBack()
    }
    
    /// 드래그해서 bottomSheetView를 위아래로 움직이는 함수
    @objc
    private func viewPanned(_ panGestureRecognizer: UIPanGestureRecognizer) {
        let translation = panGestureRecognizer.translation(in: self.view)
        
        let velocity = panGestureRecognizer.velocity(in: view)
        
        switch panGestureRecognizer.state {
        case .began:
            bottomSheetPanStartingTopConstant = bottomSheetViewTopConstraint.constant
        case .changed:
            if bottomSheetPanStartingTopConstant + translation.y > bottomSheetPanMinTopConstant {
                bottomSheetViewTopConstraint.constant = bottomSheetPanStartingTopConstant + translation.y
            }
            dimmerView.alpha = dimAlphaWithBottomSheetTopConstraint(value: bottomSheetViewTopConstraint.constant)
        case .ended:
            if velocity.y > 1500 {
                hideBottomSheetAndGoBack()
                return
            }
            let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
            let bottomPadding = view.safeAreaInsets.bottom
            
            let defaultPadding = safeAreaHeight+bottomPadding - defaultHeight
            
            let nearestValue = nearest(to: bottomSheetViewTopConstraint.constant, inValues: [bottomSheetPanMinTopConstant, defaultPadding, safeAreaHeight + bottomPadding])
            
            if nearestValue == bottomSheetPanMinTopConstant {
                print("Bottom Sheet을 Expanded 상태로 변경하기!")
                showBottomSheet(atState: .expanded)
            } else if nearestValue == defaultPadding {
                // Bottom Sheet을 .normal 상태로 보여주기
                showBottomSheet(atState: .normal)
            } else {
                // Bottom Sheet을 숨기고 현재 View Controller를 dismiss시키기
                hideBottomSheetAndGoBack()
            }
        default:
            break
        }
    }
}
