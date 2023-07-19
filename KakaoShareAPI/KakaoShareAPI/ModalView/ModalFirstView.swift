//
//  ModalFirstView.swift
//  KakaoShareAPI
//
//  Created by 양수빈 on 2023/07/18.
//

import SwiftUI

struct ModalFirstView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text("ModalFirstView")
            
            NavigationLink(destination: ModalSecondView(isPresented: $isPresented)) {
                Text("Move to ModalSecondView")
            }
            
            Button("모달 한번에 닫기") {
                isPresented.toggle()
            }
        }
    }
}

//struct ModalFirstView_Previews: PreviewProvider {
//    static var previews: some View {
//        ModalFirstView()
//    }
//}
