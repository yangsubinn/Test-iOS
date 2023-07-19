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
    @State var text: String = "-"
    @State var isPresented = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text(text)
                    .foregroundColor(.gray)
                
                Button("카카오톡 공유하기", action: {
                    shareButtonTapped()
                })
                
                // Navigation push 방법 1
                NavigationLink(destination: FirstView()) {
                    Text("Move to FirstView")
                }
                
                // Navigation push 방법 2 (isActive를 컨트롤)
//                Button("Move to FirstView") {
//                    isPresented.toggle()
//                }
                
                // Modal present 방법
//                .fullScreenCover(isPresented: $isPresented) {
//                    ModalView(isPresented: $isPresented)
//                }
            }
            .padding()
            .navigationDestination(isPresented: $isPresented) {
                FirstView()
            }
        }
        .onOpenURL { url in
            if let id = url.params()?["name"] {
                text = id as! String + " 초대 링크를 받았어요🎁"
            }
            isPresented.toggle()
        }
    }
    
    func shareButtonTapped() {
        if ShareApi.isKakaoTalkSharingAvailable() {
            // 웹 링크: 카카오톡 인앱 브라우저에서 열림
//            let link = Link(webUrl: URL(string: "https://yang-subinn.tistory.com"),
//                            mobileWebUrl: URL(string: "https://yang-subinn.tistory.com"))
            
            // 앱 링크: 파라미터를 통해 앱에 들어왔을때 특정 페이지로 이동 가능
            // 모임방 id와 같은 정보를 파라미터에 담아보내면, onOpenURL에서 param을 통해 확인 가능
            let appLink = Link(iosExecutionParams: ["name": "콩이네 집들이"])
            
            // 버튼
            let button = Button(title: "모임 참여하기", link: appLink)
            
            // 컨텐츠
            let content = Content(title: "콩이네 집들이",
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
        // 카카오톡 앱스토어 링크
        let url = "itms-apps://itunes.apple.com/app/362057947"
        if let url = URL(string: url), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(param: )
//    }
//}
