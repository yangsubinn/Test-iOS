//
//  IconTabVC.swift
//  Test
//
//  Created by 양수빈 on 2021/12/27.
//

import UIKit

class IconTabVC: UIViewController {

    var selectedIndex: Int = 0
    var previousIndex: Int = 0
    
    /// 탭바로 넣을 뷰컨들을 저장할 배열
    var viewControllers = [UIViewController]()

    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var tabView: UIView!
    var footerHeight: CGFloat = 50
    
    static let firstVC = UIStoryboard(name: "FloatingTabbar", bundle: nil).instantiateViewController(withIdentifier: "FirstVC")
    static let secondVC = UIStoryboard(name: "FloatingTabbar", bundle: nil).instantiateViewController(withIdentifier: "SecondVC")
    static let thirdVC = UIStoryboard(name: "FloatingTabbar", bundle: nil).instantiateViewController(withIdentifier: "ThirdVC")
    static let fourthVC = UIStoryboard(name: "FloatingTabbar", bundle: nil).instantiateViewController(withIdentifier: "FourthVC")
    static let fifthVC = UIStoryboard(name: "FloatingTabbar", bundle: nil).instantiateViewController(withIdentifier: "FifthVC")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 뷰컨을 차례로 배열에 추가
        viewControllers.append(TabVC.firstVC)
        viewControllers.append(TabVC.secondVC)
        viewControllers.append(TabVC.thirdVC)
        viewControllers.append(TabVC.fourthVC)
        viewControllers.append(TabVC.fifthVC)
        
        buttons[selectedIndex].isSelected = true
        iconTabChanged(sender: buttons[selectedIndex])
    }
}

extension IconTabVC {
    
    @IBAction func iconTabChanged(sender: UIButton) {
        /// 탭바의 버튼을 눌렀을 때 precious에는 이전 인덱스, selected에는 현재 탭한 tag 인덱스
        previousIndex = selectedIndex
        selectedIndex = sender.tag
        
        buttons[previousIndex].isSelected = false
        let previousVC = viewControllers[previousIndex]
        
        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()
        
        buttons.forEach { $0.isSelected = false }
        sender.isSelected = true
        
        let vc = viewControllers[selectedIndex]
        vc.view.frame = UIApplication.shared.windows[0].frame
        vc.didMove(toParent: self)
        self.addChild(vc)
        self.view.addSubview(vc.view)
        
        self.view.bringSubviewToFront(tabView)
    }

    /// UIView로 구성한 탭바 아래로 숨기기
    func hideHeader() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.tabView.frame = CGRect(x: self.tabView.frame.origin.x,
                                        y: (self.view.frame.height + self.view.safeAreaInsets.bottom + 16),
                                        width: self.tabView.frame.width,
                                        height: self.footerHeight)
        })
    }
    
    /// UIView로 구성한 탭바 위로 보이기
    func showHeader() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.tabView.frame = CGRect(x: self.tabView.frame.origin.x,
                                        y: self.view.frame.height - (self.footerHeight + self.view.safeAreaInsets.bottom + 16),
                                        width: self.tabView.frame.width,
                                        height: self.footerHeight)
        })
    }

}
