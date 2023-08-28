//
//  DynamicSize.swift
//  SwiftUI-Test
//
//  Created by 양수빈 on 2023/08/24.
//

import UIKit
import SwiftUI

struct DynamicSize: View {
    var body: some View {
        VStack(spacing: 20) {
            // 최대 글자수 15
            meetingTitleView(title: "안녕하세요")
            
            meetingTitleView(title: "안녕하세요안녕하세요안녕하세요안녕하세요")
            
            meetingTitleView(title: "바로 긴급버튼 누르기위한 모임")

            meetingTitleView(title: "일이삼 사오 육칠 팔구십 일이삼사오")

            meetingTitleView(title: "일이삼 사오육칠팔구십 일이삼사오")

            meetingTitleView(title: "일이삼 사오육칠팔 구십일 이삼사오")

            meetingTitleView(title: "일이삼 사오육칠팔구십일 이삼사오")
        }
        .padding()
    }
    
    func meetingTitleView(title: String) -> some View {
        HStack(alignment: .top) {
            Text("📌")
            
            Text("\(title.lineChanged())")
                .font(.system(size: 22))
                .padding(.trailing, 4)
            
            Rectangle()
                .fill(.gray.opacity(0.4))
                .frame(width: 56, height: 23)
            
            Spacer()
        }
        .padding(.bottom, 10)
    }
}

extension String {
    var width: CGFloat {
        let attributedString = NSAttributedString(
            string: self,
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22.0)]
        )
        let stringSize = attributedString.size()
        let widthOfString = stringSize.width
        
        return widthOfString
    }
    
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
            print("newStr: \(newStr)")
            return newStr
        }
    }
}

struct DynamicSize_Previews: PreviewProvider {
    static var previews: some View {
        DynamicSize()
    }
}
