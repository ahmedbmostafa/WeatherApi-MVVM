//
//  WeatherDataProvider.swift
//  WeatherApp
//
//  Created by AhmedHD_SL on 08/11/2022.
//

import Alamofire

protocol WeatherDataProviderDelegate: class {
    func onSuccess(_ weatherData: CurrentWeatherModel)
    func onFailure(_ error: AFError)
    func showLoader(show: Bool)
}

protocol WeatherDataProviderProtocol {
    func fetchForecast(countery: String)
    var delegate: WeatherDataProviderDelegate? { get set }
}

class WeatherDataProviderImpl: WeatherDataProviderProtocol {
    
    var weatherService: WeatherServiceProtocol!
    private var isFetching = false
    weak var delegate: WeatherDataProviderDelegate?
    
    func fetchForecast(countery: String) {
        isFetching = true
        delegate?.showLoader(show: isFetching)
        weatherService.fetchForecast(countery: countery) { [weak self] result in
            
            guard let self = self else { return }
            self.isFetching = false
            self.delegate?.showLoader(show: self.isFetching)
            
            switch result {
            case .success(let results):
                guard let data = results else { return }
                self.delegate?.onSuccess(data)
            case .failure(let error):
                self.delegate?.onFailure(error)
            }
        }
    }
    
}
