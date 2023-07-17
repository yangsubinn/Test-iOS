//
//  KakaoShareAPIApp.swift
//  KakaoShareAPI
//
//  Created by 양수빈 on 2023/07/14.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct KakaoShareAPIApp: App {
    @UIApplicationDelegateAdaptor var delegate: AppDelegate
    
    init() {
        // Kakao SDK 초기화 (AppDelegate에서 실행 가능)
        KakaoSDK.initSDK(appKey: "f33970f6c1057cc08fc9a73b9f9714c4")
    }
    
    // ContentView로 전달하기 위한 변수
    @State var param: String = ""
    
    var body: some Scene {
        WindowGroup {
            ContentView(param: $param)
                .onOpenURL { url in
                    // 카카오톡 링크로 들어온 경우, 링크 마지막에 'kakaolink?happy=cat' 형태로 파라미터가 넘어옴
                    print("🍫 URL: \(url)")
                    param = "\(String(describing: url.absoluteString.split(separator: "?").last))"
                }
        }
    }
}
