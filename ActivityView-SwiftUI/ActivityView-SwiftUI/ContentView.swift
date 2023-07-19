//
//  ContentView.swift
//  ActivityView-SwiftUI
//
//  Created by 양수빈 on 2023/07/19.
//

import SwiftUI
import FirebaseDynamicLinks

struct ContentView: View {
    @State private var isActivityViewPresented = false
    
    var body: some View {
        let url = generateDynamicLink()
        
        VStack(spacing: 20) {
            Button("더보기") {
                isActivityViewPresented = true
            }
            .background(
                ActivityView(isPresented: $isActivityViewPresented,
                             activityItems: [URL(string: url)!],
                             applicationActivities: nil))
        }
        .padding()
    }
    
    func generateDynamicLink() -> String {
        let urlPrefix = "https://teamreadme.page.link"
        let link = URL(string: "https://teamreadme.page.link/new")!
        let linkBuilder = DynamicLinkComponents(link: link, domainURIPrefix: urlPrefix)
        
        linkBuilder?.iOSParameters = DynamicLinkIOSParameters(bundleID: "com.readme.release")
        linkBuilder?.iOSParameters?.appStoreID = "1617522900"
        linkBuilder?.socialMetaTagParameters = DynamicLinkSocialMetaTagParameters()
        linkBuilder?.socialMetaTagParameters?.title = "리드미 참여해보세요!"
        linkBuilder?.socialMetaTagParameters?.imageURL = URL(string: "https://user-images.githubusercontent.com/81167570/184465852-cb05e110-a363-44d6-bcb1-729cc3c908c3.png")
        let longDynamicLink = linkBuilder?.url?.absoluteString
        print("😇", longDynamicLink)
        return longDynamicLink ?? "-"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
