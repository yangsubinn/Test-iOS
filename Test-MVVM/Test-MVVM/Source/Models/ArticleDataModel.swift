//
//  ArticleDataModel.swift
//  Test-MVVM
//
//  Created by 양수빈 on 2021/11/19.
//

import Foundation

struct ArticleList: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String?
    let description: String?
}
