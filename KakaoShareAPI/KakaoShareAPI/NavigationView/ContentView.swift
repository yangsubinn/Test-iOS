//
//  ContentView.swift
//  KakaoShareAPI
//
//  Created by 양수빈 on 2023/07/14.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKTemplate
import KakaoSDKShare

struct ContentView: View {
    @Binding var param: String
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Button("카카오톡 공유하기", action: {
                    shareButtonTapped()
                })
                Text("위의 버튼을 눌러보세요")
                    .foregroundColor(.gray)
                Text(param)
                    .foregroundColor(.gray)
                NavigationLink(destination: FirstView()) {
                    Text("Move to FirstView")
                }
            }
            .padding()
        }
    }
    
    func shareButtonTapped() {
        if ShareApi.isKakaoTalkSharingAvailable() {
            // 웹 링크: 카카오톡 인앱 브라우저에서 열림
//            let link = Link(webUrl: URL(string: "https://yang-subinn.tistory.com"),
//                            mobileWebUrl: URL(string: "https://yang-subinn.tistory.com"))
            
            // 앱 링크: 파라미터를 통해 앱에 들어왔을때 특정 페이지로 이동 가능
            // 모임방 id와 같은 정보를 파라미터에 담아보내면, App의 onOpenURL에서 확인 가능
            let appLink = Link(iosExecutionParams: ["happy": "cat"])
            
            // 버튼
            let button = Button(title: "모임 참여하기", link: appLink)
            
            // 컨텐츠
            let content = Content(title: "모임방이름1234",
                                  imageUrl: URL(string: "https://avatars.githubusercontent.com/u/81167570?v=4")!,
                                  link: appLink)
            let template = FeedTemplate(content: content, buttons: [button])
            
            if let templateJsonData = (try? SdkJSONEncoder.custom.encode(template)) {
                if let templateJsonObject = SdkUtils.toJsonObject(templateJsonData) {
                    ShareApi.shared.shareDefault(templateObject: templateJsonObject) { linkresult, error in
                        if let error = error {
                            print("error - \(error)")
                        } else {
                            print("defaultLink success")
                            guard let linkresult = linkresult else { return }
                            UIApplication.shared.open(linkresult.url)
                        }
                    }
                }
            }
        } else {
            print("카카오톡 미설치")
            moveToAppStore()
        }
    }
    
    func moveToAppStore() {
        // URL Scheme에 itms-apps 등록
//        let url = "itms-apps://itunes.apple.com/app/id1234" // 앱스토어 링크
        let url = "itms-apps://itunes.apple.com/app/362057947" // 임시 링크
        if let url = URL(string: url), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(param: <#Binding<String>#>)
//    }
//}
