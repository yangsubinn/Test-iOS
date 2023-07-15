//
//  ContentView.swift
//  TCA-iOS
//
//  Created by 양수빈 on 2023/07/15.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    let store: StoreOf<ImageReducer>
    let loadingView = LoadingView()
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(spacing: 20) {
                switch viewStore.contentState {
                case .completed, .reset:
                    AsyncImage(url: URL(string: viewStore.urlstr)) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    } placeholder: {
                        loadingView
                            .padding(131)
                    }
                case .loading:
                    loadingView
                        .padding(131)
                }
                HStack(spacing: 30) {
                    Button("이미지 랜덤 변경") {
                        viewStore.send(.renewButtonTapped)
                    }
                    Button("이미지 초기화") {
                        viewStore.send(.resetButtonTapped)
                    }
                    .foregroundColor(.gray)
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: Store(initialState: ImageReducer.State(), reducer: { ImageReducer() }))
    }
}
