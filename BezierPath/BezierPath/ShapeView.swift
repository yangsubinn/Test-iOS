//
//  ShapeView.swift
//  BezierPath
//
//  Created by 양수빈 on 2022/08/19.
//

import UIKit

class ShapeView: UIView {

    override func draw(_ rect: CGRect) {
        // 사다리꼴
        let rec = UIBezierPath()
        
        rec.lineWidth = 4
        rec.lineJoinStyle = .round
        rec.usesEvenOddFillRule = true
        
        rec.move(to: CGPoint(x: 20, y: 100))
        rec.addLine(to: CGPoint(x: UIScreen.main.bounds.width - 20, y: 100))
        rec.addLine(to: CGPoint(x: UIScreen.main.bounds.width - 100, y: 400))
        rec.addLine(to: CGPoint(x: 100, y: 400))
        
        rec.close()
        
        UIColor.yellow.set()
        rec.fill() // path 그린 뒤 선언해줘야 함 + stroke/fill 순서와 close 순서 고려
        
        UIColor.purple.set()
        rec.stroke()
        
        // 원
//        let cir = UIBezierPath(ovalIn: rect) // 화면 전체에 해당하여 그려짐 (view.frame 자체를 넣어줘서)
        let cir = UIBezierPath(ovalIn: CGRect(x: 0, y: 440, width: self.frame.width / 2, height: self.frame.width / 2))
        UIColor.red.set()
        cir.stroke()
    }
}
