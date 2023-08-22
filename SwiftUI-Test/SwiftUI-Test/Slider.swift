//
//  Slider.swift
//  SwiftUI-Test
//
//  Created by 양수빈 on 2023/08/09.
//

import SwiftUI

struct SliderView: View {
    
    @State private var rotation = 0.0
    
    var body: some View {
        VStack(spacing: 64) {
            Slider(value: $rotation, in: 0...360)

            Text("Slideer")
                .background(.yellow)
                .rotationEffect(.degrees(rotation), anchor: .center)
                .background(.gray)
        }
    }
}

struct Slider_Previews: PreviewProvider {
    static var previews: some View {
        SliderView()
    }
}
