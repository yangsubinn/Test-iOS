//
//  ContentView.swift
//  KeyChain
//
//  Created by 양수빈 on 2023/08/11.
//

import SwiftUI

struct ContentView: View {
    @State var userToken: UserToken? = nil
    
    var body: some View {
        VStack(spacing: 40) {
            Button("키체인 저장") {
                // 키체인 저장
                saveUserToken()
            }
            
            Button("키체인 업데이트") {
                updateUser()
            }
            
            Button("삭제") {
                deleteUser()
            }
            if let userToken {
                Text("accessToken: \(userToken.accessToken)")
                
                Text("refreshToken: \(userToken.refreshToken)")
            } else {
                Text("데이터가 없습니다")
            }
        }
        .padding()
    }
    
    func saveUserToken() {
        let user = UserToken(accessToken: "accessToken", refreshToken: "refreshToken")
        print(KeychainManager.shared.createUser(user))
        if let user = KeychainManager.shared.readUser() {
            userToken = user
        }
    }
    
    func deleteUser() {
        guard KeychainManager.shared.deleteUser() else {
            print("❌ Delete Failed")
            return
        }
        if let user = KeychainManager.shared.readUser() {
            userToken = user
        } else {
            userToken = nil
        }
    }
    
    func updateUser() {
        let user = UserToken(accessToken: "newAccessToken", refreshToken: "newRefreshToken")
        guard KeychainManager.shared.updateUser(user) else {
            print("❌ Update Failed")
            return
        }
        if let user = KeychainManager.shared.readUser() {
            userToken = user
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
