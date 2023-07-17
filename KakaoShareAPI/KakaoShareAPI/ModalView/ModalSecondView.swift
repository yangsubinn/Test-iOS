//
//  ModalSecondView.swift
//  KakaoShareAPI
//
//  Created by 양수빈 on 2023/07/18.
//

import SwiftUI

struct ModalSecondView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text("ModalSecondView")
            
            Button("모달 한번에 닫기") {
                isPresented.toggle()
            }
        }
    }
}

//struct ModalSecondView_Previews: PreviewProvider {
//    static var previews: some View {
//        ModalSecondView()
//    }
//}
