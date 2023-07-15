//
//  ImageReducer.swift
//  TCA-iOS
//
//  Created by 양수빈 on 2023/07/15.
//

import SwiftUI
import ComposableArchitecture

enum ContentState {
    case loading
    case completed
    case reset
}

struct ImageReducer: ReducerProtocol {
    struct State: Equatable {
        static func == (lhs: ImageReducer.State, rhs: ImageReducer.State) -> Bool {
            return false
        }
        
        let originUrl: String = "https://avatars.githubusercontent.com/u/81167570?v=4"
        var urlstr: String = "https://avatars.githubusercontent.com/u/81167570?v=4"
        var contentState: ContentState = .reset
    }
    
    enum Action: Equatable {
        case renewButtonTapped
        case resetButtonTapped
        case imageResponse(String)
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .renewButtonTapped:
            state.contentState = .loading
            return .run { send in
                let (data, _) = try await URLSession.shared.data(from: URL(string: "https://random.imagecdn.app/v1/image?width=300&height=300")! )
                await send(.imageResponse(String(decoding: data, as: UTF8.self)))
            }
        case .resetButtonTapped:
            state.contentState = .reset
            state.urlstr = state.originUrl
            return .none
        case let .imageResponse(urls):
            state.urlstr = urls
            state.contentState = .completed
            return .none
        }
    }
}
