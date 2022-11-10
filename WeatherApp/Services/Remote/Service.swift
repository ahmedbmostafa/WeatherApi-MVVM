//
//  Service.swift
//  WeatherApp
//
//  Created by AhmedHD_SL on 08/11/2022.
//

import Alamofire

protocol WeatherServiceProtocol {
    
    func fetchForecast(countery: String, completion: @escaping (Result<CurrentWeatherModel?, AFError>) -> Void)
}

class WeatherServiceImp: BaseAPI<EndPoint>, WeatherServiceProtocol {

    func fetchForecast(countery: String, completion: @escaping (Result<CurrentWeatherModel?, AFError>) -> Void) {
        self.fetchWeather(target: .fetchForecast(countery: countery)) { (result) in
            completion(result)
        }
    }

}
