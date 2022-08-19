//
//  CustomView.swift
//  BezierPath
//
//  Created by 양수빈 on 2022/08/18.
//

import UIKit

class CustomView: UIView {
        
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        
        // MARK: - drawing attribute
        path.lineWidth = 10
        
        // 선의 끝(모서리) 부분 스타일
//        path.lineCapStyle = .butt // (default) inline 느낌
//        path.lineCapStyle = .square // outline
        path.lineCapStyle = .round
        
        // 선이 꺾이는 부분 스타일
//        path.lineJoinStyle = .miter // (default) 뾰족
//        path.lineJoinStyle = .bevel // 각짐
        path.lineJoinStyle = .round
        
        // ?
        path.usesEvenOddFillRule = true
        
        // 색상
        UIColor.orange.set()
        
        // dash
        let pattern: [CGFloat] = [4, 24, 1, 14] // 4만큼 그리고 24 띄우고 1만큼 그리고 14만큼 띄우고
        path.setLineDash(pattern, count: pattern.count, phase: 0)
        
        
        // MARK: - 그리기 (시작점 - 이동할 점)
        path.move(to: CGPoint(x: 60, y: 200)) // 시작점
        path.addLine(to: CGPoint(x: 240, y: 400)) // 이동할 점
        path.addLine(to: CGPoint(x: 300, y: 300))
        
        // MARK: - stroke / fill
        // stroke or fill로 path에 따라 그려줌
        path.stroke()
        
        // MARK: - close
        // 현재까지 그리던 subpath를 닫음. 끝!
        path.close()
    }
}
