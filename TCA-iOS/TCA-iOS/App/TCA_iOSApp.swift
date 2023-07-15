//
//  TCA_iOSApp.swift
//  TCA-iOS
//
//  Created by 양수빈 on 2023/07/15.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCA_iOSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: Store(initialState: ImageReducer.State(), reducer: { ImageReducer() }))
        }
    }
}
