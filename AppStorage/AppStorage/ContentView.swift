//
//  ContentView.swift
//  AppStorage
//
//  Created by 양수빈 on 2023/07/25.
//

import SwiftUI

struct ContentView: View {
    @AppStorage(UserDefaultKey.count.rawValue) var count: Int = (UserDefaultList.count ?? 0)
    
    var body: some View {
        VStack(spacing: 20) {
            Text("count: \(count)")
            
            Button("더하기") {
                count += 1
            }
            
            Button("빼기") {
                count -= 1
            }
            
            Button("초기화") {
                UserDefaultList.count = nil
//                count = nil
                print("count: \(count)")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
