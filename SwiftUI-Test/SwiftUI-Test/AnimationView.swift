//
//  AnimationView.swift
//  SwiftUI-Test
//
//  Created by 양수빈 on 2023/08/09.
//

import SwiftUI

struct AnimationView: View {
    @State var splashStart: Bool = false
    
    // 스르륵 등장 -> 딜레이 후 위로 이동 -> 스르륵 사라지고 다른 뷰 등장
    var body: some View {
        VStack {
            Text("Hello, World!")
                .font(.largeTitle)
                .opacity(splashStart ? 1 : 0)
                .offset(y: splashStart ? 0 : +10)
                .animation(.easeInOut, value: splashStart)
        }
        .onAppear {
            withAnimation {
                splashStart = true
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                splashStart = false
            }
        }
    }
}

struct AnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView()
    }
}
