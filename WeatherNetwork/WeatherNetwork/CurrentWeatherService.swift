//
//  CurrentWeatherService.swift
//  WeatherNetwork
//
//  Created by 양수빈 on 2022/11/10.
//

import Foundation

struct CurrentWeatherService {
    static let shared = CurrentWeatherService()
    
    // 1. create url
    let urlString = "https://api.openweathermap.org/data/2.5/weather"
    let appid = "118e38c88f78ef1eb986616b22f12fec"
    let lat = "37.5666791"
    let lon = "126.9782914"
    let units = "metric"
    
    func fetchCurrentWeatherData(completion: @escaping (Result<Any, Error>) -> ()) {
        guard var urlComponents = URLComponents(string: urlString) else { return }
        
        let query: [String: String] = [
            "appid": appid,
            "lat": lat,
            "lon": lon,
            "units": units
        ]
        
        let queryItemArray = query.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        urlComponents.queryItems = queryItemArray
        
        guard let requestURL = urlComponents.url else { return }
        
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
        dataTask.resume()
        
//        if let url = URL(string: urlString) {
//            // 2. create urlsession
//            // URLSession 유형: default(기본), ephemeral(쿠키나 캐시 X), background(백그라운드에서 다운로드/업로드)
//            let session = URLSession(configuration: .default)
//
//            var requestURL = URLRequest(url: url)
//            // header
//            requestURL.setValue(appid, forHTTPHeaderField: "appid")
//            requestURL.setValue(lat, forHTTPHeaderField: "lat")
//            requestURL.setValue(lon, forHTTPHeaderField: "lon")
//            requestURL.setValue(units, forHTTPHeaderField: "units")
//
//            // 3. give urlsession task
//            // SessionTask 작업 유형: dataTask, uploadTask, downloadTask
//            let dataTask = session.dataTask(with: requestURL) { (data, response, error) in
//                if error != nil {
//                    print(error!)
//                    return
//                }
//
//                if let safeData = data {
//                    do {
//                        print("safeData", safeData)
//                        let decodedData = try JSONDecoder().decode(CurrentWeatherEntity.self, from: safeData)
//                        print("decodedData", decodedData)
//                        completion(.success(decodedData))
//                    } catch let DecodingError.dataCorrupted(context) {
//                        print(context)
//                    } catch let DecodingError.keyNotFound(key, context) {
//                        print("Key '\(key)' not found:", context.debugDescription)
//                        print("codingPath:", context.codingPath)
//                    } catch let DecodingError.valueNotFound(value, context) {
//                        print("Value '\(value)' not found:", context.debugDescription)
//                        print("codingPath:", context.codingPath)
//                    } catch let DecodingError.typeMismatch(type, context)  {
//                        print("Type '\(type)' mismatch:", context.debugDescription)
//                        print("codingPath:", context.codingPath)
//                    } catch {
//                        print("error: ", error)
//                    }
//
//                }
//            }
//            // 4. start task
//            dataTask.resume()
//        }
    }
}
