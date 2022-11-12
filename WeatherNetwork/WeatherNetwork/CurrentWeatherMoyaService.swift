//
//  CurrentWeatherMoyaService.swift
//  WeatherNetwork
//
//  Created by 양수빈 on 2022/11/12.
//

import Foundation

import Moya

enum CurrentWeatherMoyaService {
    case getCurrentWeather(lat: String, lon: String, units: String)
}

extension CurrentWeatherMoyaService: TargetType {
    var baseURL: URL {
        return URL(string: Const.urlString)!
    }
    
    var path: String {
        switch self {
        case .getCurrentWeather:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCurrentWeather:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getCurrentWeather(let lat, let lon, let units):
            return .requestParameters(
                parameters: ["appid": Const.appid,
                             "lat": lat,
                             "lon": lon,
                             "units": units],
                encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return nil
        }
    }
}
