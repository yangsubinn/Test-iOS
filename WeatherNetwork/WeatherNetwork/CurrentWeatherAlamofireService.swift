//
//  CurrentWeatherAlamofireService.swift
//  WeatherNetwork
//
//  Created by 양수빈 on 2022/11/11.
//

import Foundation

import Alamofire

/**
 1. Send Request
 2. Handle Response
 */

struct CurrentWeatherAlamofireService {
    static let shared = CurrentWeatherAlamofireService()
    
    func fetchCurrentWeatherData(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        // parameters 생성
        let parameters: Parameters = [
            "appid": Const.appid,
            "lat": Const.lat,
            "lon": Const.lon,
            "units": Const.units
        ]
        
        // 1. Send Request
        // URLSession과 달리 직접 URLSession을 생성하고 Task를 부여하지 않음
        // request 안에 url, methoe, parameters, encoding type 등 설정
        let dataRequest = AF.request(Const.urlString,
                                     method: .get,
                                     parameters: parameters,
                                     encoding: URLEncoding.queryString)
        
        // 2. Handle Response
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
