//
//  EndPoint.swift
//  WeatherApp
//
//  Created by AhmedHD_SL on 08/11/2022.
//

import Alamofire

enum EndPoint {
    case fetchForecast(countery: String)
}

extension EndPoint: TargetType {
    
    var base: String {
        switch self {
        default:
            return valueOfSecret(named: "BaseURL")
        }
    }
    var ApiKey: String {
        switch self {
        default:
            return valueOfSecret(named: "ApiKey")
        }
    }
    var path: String {
        switch self {
        case .fetchForecast(let countery):
            return "forecast.json?key=\(ApiKey)&q=\(countery)&days=3&aqi=no&alerts=no"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchForecast:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .fetchForecast:
            return .requestPlain
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        default:
            let header: HTTPHeaders = ["Content-Type": "application/json"]
            return header
        }
    }
}
