//
//  MockWeatherViewModel.swift
//  WeatherAppTests
//
//  Created by AhmedHD_SL on 10/11/2022.
//

import XCTest
@testable import WeatherApp

class MockWeatherViewModel: WeatherViewModelProtocol {

    
    var dataProvider: WeatherDataProviderProtocol!
    var isNumberOfItemsCalls = false
    var isGetForecastCellViewModelCalls = false

    var numberOfItems: Int {
        isNumberOfItemsCalls = true
        return 1
    }

    var output: WeatherViewModelOutput?

    func getForecastCellViewModel(index: Int) -> ForecastCellViewModel {
        isGetForecastCellViewModelCalls = true
        let forecastday = try! JSONDecoder().decode(Forecastday.self, from: forecastStub)
//        print("pla=",forecastday)
        return ForecastCellViewModel(forecastday)
    }

    func didLoad(countery: String) {
        
    }
}
