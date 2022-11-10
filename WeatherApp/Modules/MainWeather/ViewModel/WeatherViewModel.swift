//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by AhmedHD_SL on 08/11/2022.
//

import Foundation
import Alamofire

typealias WeatherViewModelOutput = (WeatherViewModel.Output) -> ()

protocol WeatherViewModelProtocol {
    var dataProvider: WeatherDataProviderProtocol! {get}
    var output: WeatherViewModelOutput? { get set }
    var numberOfItems: Int { get }
    func getForecastCellViewModel(index : Int) -> ForecastCellViewModel
    func didLoad(countery:String)
}


class WeatherViewModel: WeatherViewModelProtocol{
    
    enum Output {
        case updateForecasrData(current: CurrentWeatherModel)
        case mainTime(time: String)
        case mainCity(city: String)
        case mainDate(date:String)
        case mainIcon(icon:[String], code:String, text: String)
        case mainTemp(temp: String)
        case mainWind(wind: String)
        case mainHumidity(humidity: String)
        case dayDescription(text: String)
        case showActivityIndicator(show: Bool)
        case showError(error: Error)
    }
    
    var dataProvider: WeatherDataProviderProtocol!
    
    init(withDataProvider dataProvider: WeatherDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    var output: WeatherViewModelOutput?
    
    private var weatherData: CurrentWeatherModel?
    
    var mainCity: String {
        return weatherData?.location?.name ?? ""
    }
    
    var mainIcon: [String] {
        return generateIcon(path: path)
    }
    
    var mainIconCode:String = ""
    var mainText: String = ""
    private var path: String {
        return weatherData?.current?.condition?.icon ?? ""
    }
    
    var mainTime: String {
        return (weatherData?.location?.localtime ?? "").convertDateGMT(from: "yyyy-MM-dd HH:mm", to: "h:mm a")
    }
    
    var mainDate: String {
        return (weatherData?.location?.localtime ?? "").convertDateGMT(from: "yyyy-MM-dd HH:mm", to: "EEEE, dd MMM yyyy")
    }
    
    var mainTemp: Double {
        return weatherData?.current?.tempF ?? 0
    }
    
    var wind: Double {
        return weatherData?.current?.windMph ?? 0
    }
    
    var humidity: Double {
        weatherData?.current?.humidity ?? 0
    }
    
    var dayDescription: String {
        weatherData?.current?.condition?.text ?? ""
    }
    private var allForecastViewModels = [ForecastCellViewModel]() {
        didSet {
            output?(.updateForecasrData(current: self.weatherData!))
        }
    }
    
    private var forecastDataSourceViewModels: [ForecastCellViewModel] {
        return allForecastViewModels
    }
    
    var numberOfItems: Int {
        forecastDataSourceViewModels.count
    }
    
    func getForecastCellViewModel(index: Int) -> ForecastCellViewModel {
        forecastDataSourceViewModels[index]
    }
    
    func didLoad(countery:String) {
        fetchForecast(countery: countery)
    }
    
    
    private func fetchForecast(countery:String) {
        dataProvider.fetchForecast(countery: countery)
    }
    
    private func generateIcon(path: String) -> [String] {
        var text = ""
        var iconCode = ""
        if path.contains("day") {
            text = "day"
            iconCode = path.slice(from: "\(text)/", to: ".") ?? "350"
        } else if path.contains("night") {
            text = "night"
            iconCode = path.slice(from: "\(text)/", to: ".") ?? "350"
        }
        let fm = FileManager.default
        self.mainIconCode = iconCode
        self.mainText = text
        return fm.getListFileNameInBundle(bundlePath: "\(text).bundle")
    }
    
}

extension WeatherViewModel: WeatherDataProviderDelegate {
    
    func showLoader(show: Bool) {
        output?(.showActivityIndicator(show: show))
    }
    
    func onSuccess(_ weatherData: CurrentWeatherModel) {
        self.weatherData = weatherData
        output?(.updateForecasrData(current: weatherData))
        output?(.mainCity(city: mainCity))
        output?(.mainIcon(icon: mainIcon, code: mainIconCode, text: mainText))
        output?(.mainTime(time: mainTime))
        output?(.mainDate(date: mainDate))
        output?(.mainTemp(temp: "\(mainTemp)"))
        output?(.mainWind(wind: "\(wind)" + " mph"))
        output?(.mainHumidity(humidity: "\(humidity)" + " %"))
        output?(.dayDescription(text: dayDescription))
        guard let forecastday = weatherData.forecast?.forecastday else { return }
        allForecastViewModels.append(contentsOf: forecastday.map { ForecastCellViewModel.init($0) })
        
    }
    
    func onFailure(_ error: AFError) {
        output?(.showError(error: error))
    }
    
}
