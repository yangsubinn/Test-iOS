//
//  ActivityView_SwiftUIApp.swift
//  ActivityView-SwiftUI
//
//  Created by 양수빈 on 2023/07/19.
//

import SwiftUI
import FirebaseCore

@main
struct ActivityView_SwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
