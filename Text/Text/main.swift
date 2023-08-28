//
//  main.swift
//  Text
//
//  Created by 양수빈 on 2023/08/24.
//

import Foundation

extension String {
    func lineChanged(_ maxCount: Int = 11) -> String {
        if self.count <= maxCount {
            return self
        } else {
            // 최대 글자수보다 크면 줄바꿈한 문자열 리턴
            var newStr = ""
            var length = 0
            let truncatedStr = self.split(separator: " ")
            
            for str in truncatedStr.enumerated() {
                length += str.element.count
                // 한 줄에 들어갈 글자수가 maxCount보다 크면 줄바꿈, 아니면 그대로 newStr 추가
                if length >= maxCount {
                    if str.offset == 0 {
                        print(str)
                        var copyStr = str.element
                        newStr += copyStr.prefix(maxCount) + "\n"
                        copyStr.removeFirst(maxCount)
                        newStr += copyStr
                        length = copyStr.count
                        continue
                    } else {
                        newStr += "\n"
                        length = 0
                    }
                }
                newStr += str.element + " "
            }
            return newStr
        }
    }
}

//let new = "바로 긴급버튼 누르기위한 모임".lineChanged()
//let new = "바로 긴급버튼 바로 누르기위한 모임".lineChanged()
let new = "안녕하세요안녕하세요안녕하세요안녕하세요".lineChanged() // 안녕하세요안녕하세요
//let new = "일이삼 사오 육칠 팔구십 일이삼사오".lineChanged()
print("======================")
print("🐥 \(new)")
//print("바로 긴급버튼 누르기위한 모임".lineChanged())


