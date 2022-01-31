//
//  TestVC.swift
//  Test
//
//  Created by 양수빈 on 2021/09/22.
//

/**
    closure 테스트용 VC
 */

import UIKit

class TestVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        hello(name: "양수빈")
//        hello(name: "양숲", time: 3)
        let hello = helloGenerator(message: "안녕하쇼")
    }
    
//    func hello(to name: String, numberOfTimes time: Int) {
//        for _ in 0..<time {
//            print(name)
//        }
//    }
    
    // 초기값 설정
//    func hello(name: String, time: Int = 3) {
//        for _ in 0..<time {
//            print(name)
//        }
//    }
    
    // 함수 안에 closure
//    func hello(name: String, time: Int) {
//      func message(name: String) -> String {
//        return "\(name)님 안녕하세요!"
//      }
//
//      for _ in 0..<time {
//        print(message(name: name))
//      }
//    }
    
    // 함수 안에 closure 안에 closure
    func helloGenerator(message: String) -> (String, String) -> String {
        return { (firstName: String, lastName: String) -> String in
            return lastName + firstName + message
        }
    }
}
