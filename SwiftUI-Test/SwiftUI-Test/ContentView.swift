//
//  ContentView.swift
//  SwiftUI-Test
//
//  Created by 양수빈 on 2023/08/09.
//

import SwiftUI

enum Platform {
    case kakao
    case apple
}

struct ContentView: View {
    let platform = Platform.kakao
    let date = "2023-04-09".split(separator: "-").compactMap({ String($0) })
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink("Slider") { SliderView() }
                
                NavigationLink("Animation") { AnimationView() }
                
                Text("\(date[0])년 \(date[1])월 \(date[2])일")
                
                Text("13:05:00".prefix(5))
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
