//
//  BottomSheetViewController.swift
//  BottomSheet
//
//  Created by 양수빈 on 2022/02/06.
//

import UIKit

class BottomSheetVC: UIViewController {
    
    /// bottomSheet 올라와있는 정도에 따른 상태
    enum BottomSheetViewState {
        case expanded
        case normal
    }
    
    // MARK: - Properties
    
    // contentViewController: 보여질 UIViewController
    // dimmerView: bottomSheet 뒤에 깔릴 어두운 UIView
    // bottomSheetView: contentViewController가 올라갈 UIView 그자체
    // defaultHeight: bottomSheet의 기본 높이
    // bottomSheeetViewTopConstrint: bottomSheet의 상단 constraint를 조정하기 위한 변수
    private let contentVC: UIViewController
    private let dimmerView = UIView()
    private let bottomSheetView = UIView()
    private var bottomSheetViewTopConstraint: NSLayoutConstraint!
    private var defaultHeight: CGFloat = 300
    
    // TODO: - 왜 변수를 두번 썼을까?
    // Bottom Sheet과 safe Area Top 사이의 최소값을 지정하기 위한 프로퍼티, 기본값 30
    var bottomSheetPanMinTopConstant: CGFloat = 30.0
    // 드래그 하기 전에 Bottom Sheet의 top Constraint value를 저장하기 위한 프로퍼티
    private lazy var bottomSheetPanStartingTopConstant: CGFloat = bottomSheetPanMinTopConstant
    
    // MARK: - Initialize
    // initializer을 통해서 UIViewController을 contentViewController로 넣어줍니다.
    init(contentViewController: UIViewController) {
        self.contentVC = contentViewController
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycles
    
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
        dimmerView.alpha = 0.0 // 스르륵 나타나는 애니메이션 효과를 위해 초기값 0.0으로 지정
        
        // bottomSheetViewController가 있는 위에 contentVC가 보이도록 하는 방법
        // 1. contentVC를 self(BottomSheetViewController의 자식으로 설정
        addChild(contentVC)
        // 2.추가된 contentVC의 view가 맨 앞에 등장하게 설정
        bottomSheetView.addSubview(contentVC.view)
        // 3. contentVC 입장에서는 언제 부모VC에 추가되는지 모르기 때문에 contentVC에게 추가 및 제거되는 시점을 알려줌
        contentVC.didMove(toParent: self)
        
        bottomSheetView.backgroundColor = .white
        bottomSheetView.layer.cornerRadius = 10
        bottomSheetView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // 상단 왼쪽, 오른쪽 모서리에만 cornerRadius 적용
        bottomSheetView.clipsToBounds = true
    }
    
    private func setLayout() {
        view.addSubview(dimmerView)
        view.addSubview(bottomSheetView)
        
        dimmerView.translatesAutoresizingMaskIntoConstraints = false
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        contentVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        dimmerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dimmerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        dimmerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        dimmerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // TODO: - 레이아웃 코드 정리
        let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
        bottomSheetViewTopConstraint = bottomSheetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant)
        NSLayoutConstraint.activate([
            bottomSheetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomSheetViewTopConstraint,
        ])
        
        NSLayoutConstraint.activate([
            contentVC.view.topAnchor.constraint(equalTo: bottomSheetView.topAnchor),
            contentVC.view.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor),
            contentVC.view.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor),
            contentVC.view.bottomAnchor.constraint(equalTo: bottomSheetView.bottomAnchor)
        ])
    }
    
    // bottomSheet 스크롤할때 상태에 따라 딱 스크롤 멈췄을때 보이는 bottomSheet 높이 지정
    private func showBottomSheet(atState: BottomSheetViewState = .normal) {
        if atState == .normal {
            let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
            let bottomPadding: CGFloat = view.safeAreaInsets.bottom
            bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - defaultHeight
        } else {
            bottomSheetViewTopConstraint.constant = bottomSheetPanMinTopConstant
        }
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            // bottomSheet의 상단 constraint에 따라 dimmerView의 alpha 값 조정
            self.dimmerView.alpha = self.dimAlphaWithBottomSheetTopConstraint(value: self.bottomSheetViewTopConstraint.constant)
            self.view.layoutIfNeeded() // 즉시 값이 변경되어야 하는 애니메이션에 적용
        }, completion: nil)
    }
    
    /// dimmerView에 tapGesture 추가하는 함수
    private func setTapGesture() {
        let dimmerTap = UITapGestureRecognizer(target: self, action: #selector(dimmerViewTapped(_:)))
        dimmerView.addGestureRecognizer(dimmerTap)
        dimmerView.isUserInteractionEnabled = true
    }
    
    /// ViewController의 view에 Pan Gesture Recognizer 추가하는 함수
    private func setPanGesture() {
        let viewPan = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
        
        // 기본적으로 iOS는 터치가 드래그하였을 때 딜레이가 발생함
        // 우리는 드래그 제스쳐가 바로 발생하길 원하기 때문에 딜레이가 없도록 아래와 같이 설정
        viewPan.delaysTouchesBegan = false
        viewPan.delaysTouchesEnded = false
        view.addGestureRecognizer(viewPan)
    }
    
    /// bottomSheet를 내리고 dimmerView를 삭제하는 동시에 dismiss 시켜서 원래 뷰로 이동
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
    
    // 주어진 CGFloat 배열의 값 중 number로 주어진 값과 가까운 값을 찾아내는 메소드
    private func nearest(to number: CGFloat, inValues values: [CGFloat]) -> CGFloat {
        guard let nearestVal = values.min(by: { abs(number - $0) < abs(number - $1) })
        else { return number }
        return nearestVal
    }
    
    /// bottomSheet의 상단 constrint에 따라 더 낮은 알파값 리턴
    private func dimAlphaWithBottomSheetTopConstraint(value: CGFloat) -> CGFloat {
        // 기본 dimmerView 알파값
        let fullDimAlpha: CGFloat = 0.7
        
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        
        // bottomSheet가 완전히 올라왔을때, dimmerView alpha 값 0.7
        let fullDimPosition = (safeAreaHeight + bottomPadding - defaultHeight) / 2
        
        // bottomSheet가 완전히 내려갔을때, dimmerView alpha 값 0.0
        let noDimPosition = safeAreaHeight + bottomPadding
        
        // bottomSheet의 top constraint가 각 높이에 따라 각 alpha 값을 리턴
        if value < fullDimPosition {
            return fullDimAlpha
        } else if value > noDimPosition {
            return 0.0
        } else {
            // 그 외, top constraint 값에 따라 0.0과 0.7 사이의 alpha 값 리턴
            return fullDimAlpha * (1 - ((value - fullDimPosition) / (noDimPosition - fullDimPosition)))
        }
    }
    
    // MARK: - @objc
    /// dimmerView를 탭했을때 화면 꺼지도록 하는 함수
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
                // .expanded 상태의 BottomSheet
                showBottomSheet(atState: .expanded)
            } else if nearestValue == defaultPadding {
                // .normal 상태의 BottomSheet
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
