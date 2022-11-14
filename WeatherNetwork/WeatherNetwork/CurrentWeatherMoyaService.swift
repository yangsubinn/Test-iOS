//
//  CurrentWeatherMoyaService.swift
//  WeatherNetwork
//
//  Created by 양수빈 on 2022/11/12.
//

import Foundation

import Moya

/**
 1. enum형 Service에 사용할 api case 추가
 2. Service가 TargetType을 상속받도록 한뒤, 그 안의 내용을 적절히 추가
 3. API에서 Service의 case에 접근하여 해당 case의 요소를 갖고 request, response 처리
 */

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
