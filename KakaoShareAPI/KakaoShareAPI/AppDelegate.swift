//
//  AppDelegate.swift
//  KakaoShareAPI
//
//  Created by 양수빈 on 2023/07/14.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    /// 앱이 켜진 뒤 처리할 명령
    /// - ex) push notification config, delegate
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
}
