//
//  Storyboarded.swift
//  CoordinatorPattern
//
//  Created by 양수빈 on 2022/09/23.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        // 해당 파일의 풀네임
        // ex) CoordinatorPattern.ViewController
        let fullName = NSStringFromClass(self)
        // .을 기준으로 split해 뒤의 VC 파일 이름만
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
