//
//  CurrentWeatherMoyaAPI.swift
//  WeatherNetwork
//
//  Created by 양수빈 on 2022/11/12.
//

import Foundation

import Moya

public class CurrentWeatherMoyaAPI {
    var currentWeatherProvider = MoyaProvider<CurrentWeatherMoyaService>()
    
    func getCurrentWeather(completion: @escaping (NetworkResult<Any>) -> Void) {
        currentWeatherProvider.request(.getCurrentWeather(lat: Const.lat, lon: Const.lon, units: Const.units)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data)
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
