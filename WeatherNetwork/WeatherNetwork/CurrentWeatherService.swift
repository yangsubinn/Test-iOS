//
//  CurrentWeatherService.swift
//  WeatherNetwork
//
//  Created by 양수빈 on 2022/11/10.
//

import Foundation

/**
 1. Create URL
 2. Create URLSession
 3. Give URLSession Task
 4. Start Task
 */

struct CurrentWeatherService {
    static let shared = CurrentWeatherService()
    
    func fetchCurrentWeatherData(completion: @escaping (NetworkResult<Any>) -> ()) {
        // 1. Create URL
        // URLComponents로 생성하여 query parameter 추가
        guard var urlComponents = URLComponents(string: Const.urlString) else { return }
        
        // query parameter
        let query: [String: String] = [
            "appid": Const.appid,
            "lat": Const.lat,
            "lon": Const.lon,
            "units": Const.units
        ]
        
        // parameter 하나씩 URLQueryItem에 추가
        let queryItemArray = query.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        urlComponents.queryItems = queryItemArray
        
        // 요청 URL
        guard let requestURL = urlComponents.url else { return }
        
        // 2. Create URLSession
        // 3. Give URLSession Task
        // Session 생성 및 Task 부여
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: requestURL) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            if let safeData = data {
                do {
                    let decodedData = try JSONDecoder().decode(CurrentWeatherEntity.self, from: safeData)
                    completion(.success(decodedData))
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
                
            }
        }
        
        // 4. Start Task
        dataTask.resume()
    }
}
