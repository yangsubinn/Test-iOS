//
//  ThirdVC.swift
//  Test
//
//  Created by 양수빈 on 2021/12/26.
//

import UIKit

class ThirdVC: UIViewController {

//    @IBOutlet weak var scrollView: UIScrollView!
//    var headerVisible = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 2 * self.view.frame.height)
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
//        performHeaderCheck(translation: translation)
//    }
//    
//    func performHeaderCheck(translation: CGPoint) {
//        if translation.y == 0 { return }
//        if translation.y > 0 {
//            /// Scroll Down
//            if !headerVisible {
//                showHeader()
//            }
//        } else {
//            /// Scroll Up
//            if headerVisible {
//                hideHeader()
//            }
//        }
//    }
//    
//    func hideHeader() {
//        self.headerVisible = false
//        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
//            let parent = self.parent as! TabVC
//            parent.hideHeader()
//        })
//    }
//    
//    func showHeader() {
//        self.headerVisible = true
//        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
//            let parent = self.parent as! TabVC
//            parent.showHeader()
//        })
//    }

}
