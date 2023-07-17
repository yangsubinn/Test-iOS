//
//  MoveView.swift
//  KakaoShareAPI
//
//  Created by 양수빈 on 2023/07/18.
//

import SwiftUI

struct FirstView: View {
    @State var isPresented = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("FirstView")
            
            NavigationLink(destination: SecondView()) {
                Text("Move to SecondView")
            }
            
            Button("Show ModalView") {
                isPresented.toggle()
            }
            .fullScreenCover(isPresented: $isPresented) {
                ModalView(isPresented: $isPresented)
            }
//            .sheet(isPresented: $isPresented) {
//                ModalView()
//            }
        }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
