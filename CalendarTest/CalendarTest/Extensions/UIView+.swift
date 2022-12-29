//
//  UIView+.swift
//  CalendarTest
//
//  Created by 양수빈 on 2022/12/15.
//

import UIKit

extension UIView {
    public func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}
