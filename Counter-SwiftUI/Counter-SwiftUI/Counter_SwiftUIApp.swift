//
//  Counter_SwiftUIApp.swift
//  Counter-SwiftUI
//
//  Created by 양수빈 on 2023/07/15.
//

import SwiftUI
import ComposableArchitecture

@main
struct Counter_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: Store(initialState: Feature.State(), reducer: {
                Feature()
            }))
        }
    }
}
