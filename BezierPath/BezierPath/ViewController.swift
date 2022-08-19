//
//  ViewController.swift
//  BezierPath
//
//  Created by 양수빈 on 2022/08/18.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 직선 또는 곡선으로 만들어진 path로 customView에서만 렌더링 가능
        let customView = CustomView(frame: self.view.frame)
        customView.backgroundColor = .clear
//        self.view.addSubview(customView)
        
        let shapeView = ShapeView(frame: self.view.frame)
        shapeView.backgroundColor = .clear
        self.view.addSubview(shapeView)
    }
}

