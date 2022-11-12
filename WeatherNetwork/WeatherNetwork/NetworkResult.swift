//
//  NetworkResult.swift
//  WeatherNetwork
//
//  Created by 양수빈 on 2022/11/11.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
