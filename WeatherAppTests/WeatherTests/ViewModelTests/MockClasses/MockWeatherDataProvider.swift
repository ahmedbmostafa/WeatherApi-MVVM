//
//  MockWeatherDataProvider.swift
//  WeatherAppTests
//
//  Created by AhmedHD_SL on 10/11/2022.
//

import XCTest
@testable import WeatherApp

class MockWeatherDataProvider: WeatherDataProviderProtocol {

    var delegate: WeatherDataProviderDelegate?

    var closure: (() -> ())?

    func fetchForecast(countery: String) {
        closure?()
    }
}
