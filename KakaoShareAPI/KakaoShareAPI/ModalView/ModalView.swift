//
//  ModalView.swift
//  KakaoShareAPI
//
//  Created by 양수빈 on 2023/07/18.
//

import SwiftUI

struct ModalView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("ModalView")
                
                NavigationLink(destination: ModalFirstView(isPresented: $isPresented)) {
                    Text("Move to ModalFirstView")
                }
                
                Button("Back to FirstView") {
                    isPresented.toggle()
                }
            }
        }
    }
}

//struct ModalView_Previews: PreviewProvider {
//    static var previews: some View {
//        ModalView()
//    }
//}
