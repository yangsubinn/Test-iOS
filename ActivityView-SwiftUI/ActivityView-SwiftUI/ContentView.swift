//
//  ContentView.swift
//  ActivityView-SwiftUI
//
//  Created by 양수빈 on 2023/07/19.
//

import SwiftUI
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKTalk

struct ContentView: View {
    @State private var isActivityViewPresented = false
    @State private var item: ActivityItem?
    
    var body: some View {
        VStack {
            Button("더보기") {
                isActivityViewPresented = true
            }
            .background(
                ActivityView(isPresented: $isActivityViewPresented,
                             activityItems: [URL(string: "https://teamreadme.page.link/new")!],
                             applicationActivities: nil))
//            Button {
//                item = ActivityItem(
//                    items: [URL(string: "https://github.com/yangsubinn")!],
//                    activities: [],
//                    excludedTypes: [])
//            } label: {
//                Text("더보기")
//            }
//            .activitySheet($item)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
