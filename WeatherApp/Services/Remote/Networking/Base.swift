//
//  Base.swift
//  WeatherApp
//
//  Created by AhmedHD_SL on 08/11/2022.
//

import Alamofire

class BaseAPI<T: TargetType> {


    func fetchWeather (target: T, completion: @escaping(Result<CurrentWeatherModel?, AFError>) -> Void) {
        let method = HTTPMethod(rawValue: target.method.rawValue)
        AF.request(target.base + target.path, method: method, encoding: JSONEncoding.default, headers: target.headers)
            .response { response in
                switch response.result {
                case.success:
                    guard let data = response.value else {return}
                    do {
                        let responseOBj = try JSONDecoder().decode(CurrentWeatherModel.self, from: data!)
                        completion(.success(responseOBj))
                    }
                    catch let err{
                        debugPrint(err)
                    }
                case .failure(let err):
                    debugPrint(err)
                    completion(.failure(err))
                }
            }
    }
}
