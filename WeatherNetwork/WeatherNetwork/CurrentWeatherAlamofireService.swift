//
//  CurrentWeatherAlamofireService.swift
//  WeatherNetwork
//
//  Created by 양수빈 on 2022/11/11.
//

import Foundation

import Alamofire

struct CurrentWeatherAlamofireService {
    static let shared = CurrentWeatherAlamofireService()
    
    let urlString = "https://api.openweathermap.org/data/2.5/weather"
    let appid = "118e38c88f78ef1eb986616b22f12fec"
    let lat = "37.5666791"
    let lon = "126.9782914"
    let units = "metric"
    
    func fetchCurrentWeatherData(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let parameters: Parameters = [
            "appid": appid,
            "lat": lat,
            "lon": lon,
            "units": units
        ]
        
        let dataRequest = AF.request(urlString,
                                     method: .get,
                                     parameters: parameters,
                                     encoding: URLEncoding(destination: .queryString))
        
        dataRequest.response { data in
            switch data.result {
            case .success(_):
                guard let statusCode = data.response?.statusCode else { return }
                guard let value = data.value else { return }
                let networkResult = self.judgeStatus(by: statusCode, value ?? Data())
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200:
            return isValidData(data: data)
        default:
            return .pathErr
        }
    }

    private func isValidData(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()

        guard let decodedData = try? decoder.decode(CurrentWeatherEntity.self, from: data) else { return .pathErr }
        return .success(decodedData)
    }
}
