//
//  ScrollView.swift
//  SwiftUI-Test
//
//  Created by 양수빈 on 2023/08/20.
//

import SwiftUI

enum Tab {
    case first
    case second
}

struct InfiniteScrollView: View {
    @State var tab: Tab = .first
    @State var firstList: [Int] = Array(1...20)
    @State var secondList: [Int] = Array(200...220)
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 20) {
                Button("1~100") {
                    tab = .first
                }
                
                Button("200~300") {
                    tab = .second
                }
            }
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 20) {
                    ForEach((tab == .first ? $firstList : $secondList), id: \.self) { num in
                        Text("num: \(num.wrappedValue)")
                            .padding()
                            .background(.gray)
                            .padding(.horizontal)
                            .onAppear {
                                let list = tab == .first ? $firstList : $secondList
                                guard let index = list.projectedValue.firstIndex(where: { $0.wrappedValue == num.wrappedValue }) else { return }
                                
                                if index % 20 == 19 {
                                    print("📍 \(index)")
                                    if index <= 100 {
                                        let last = list.wrappedValue.last!
                                        list.wrappedValue.append(contentsOf: Array(last+1...last+20))
                                    }
                                }
                            }
                    }
                }
            }
        }
    }
}

struct ScrollView_Previews: PreviewProvider {
    static var previews: some View {
        InfiniteScrollView()
    }
}
