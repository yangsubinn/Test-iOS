//
//  ImageService.swift
//  TCA-iOS
//
//  Created by 양수빈 on 2023/07/15.
//

import Foundation

struct ImageService {
    static var shared = ImageService()
    
    private let baseURL = "https://picsum.photos/200"
    
    mutating func fetchImageSearchData(start: Int = 1, display: Int = 1, completion: @escaping (NetworkResult<Any>) -> ()) {
        guard var urlComponents = URLComponents(string: baseURL) else { return }
        
        let query: [String: String] = ["width": "300", "height": "300"]
        let queryItemArray = query.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        urlComponents.queryItems = queryItemArray
        
        guard let requestUrl = urlComponents.url else { return }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            if let safeData = data {
                do {
                    let decodedData = try JSONDecoder().decode(String.self, from: safeData)
                    print(decodedData)
                    completion(.success(decodedData))
                } catch(let err) {
                    print("err -", err)
                }
            }
        }
        
        dataTask.resume()
    }
}
