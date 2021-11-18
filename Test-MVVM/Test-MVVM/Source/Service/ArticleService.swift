//
//  ArticleService.swift
//  Test-MVVM
//
//  Created by 양수빈 on 2021/11/19.
//

import Foundation

class ArticleService {
    func getArticles(url: URL, completion: @escaping ([Article]?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                let articleList = try? JSONDecoder().decode(ArticleList.self, from: data)
                print(articleList)
                if let articleList = articleList {
                    completion(articleList.articles)
                }
                print(articleList?.articles)
            }
        }.resume()
    }
}
