//
//  UserDefaultKeyList.swift
//  AppStorage
//
//  Created by 양수빈 on 2023/07/25.
//

import Foundation

enum loginPlatform: String {
    case apple = "apple"
    case kakao = "kakao"
}

enum UserDefaultKey: String {
    case accessToken = "accessToken"
    case platform = "platform"
    case count = "count"
}

public struct UserDefaultList {
    @UserDefaultWrapper<String>(key: .accessToken) public static var accessToken
    @UserDefaultWrapper<String>(key: .platform) public static var platform
    @UserDefaultWrapper<Int>(key: .count) public static var count
}
