//
//  Day.swift
//  CalendarTest
//
//  Created by 양수빈 on 2022/12/15.
//

import Foundation

@frozen
public enum Week {
    case sun, mon, tue, wed, thu, fri, sat
    
    static let allCases: [Week] = [.sun, .mon, .tue, .wed, .thu, .fri, .sat]
}

extension Week {
//    public var allCase: [Week] {
//        return [.sun, .mon, .tue, .wed, .thu, .fri, .sat]
//    }
    
    public var ko: String {
        switch self {
        case .sun:
            return "일"
        case .mon:
            return "월"
        case .tue:
            return "화"
        case .wed:
            return "수"
        case .thu:
            return "목"
        case .fri:
            return "금"
        case .sat:
            return "토"
        }
    }
}
