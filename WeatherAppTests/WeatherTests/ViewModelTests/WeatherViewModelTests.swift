//
//  WeatherViewModelTests.swift
//  WeatherAppTests
//
//  Created by AhmedHD_SL on 10/11/2022.
//

import XCTest
@testable import WeatherApp

class WeatherViewModelTests: XCTestCase {
    
    var dataProvider: MockWeatherDataProvider!
    var viewModel: WeatherViewModel!
    var view = MockWeatherVC()
    
    override func setUp() {
        super.setUp()
        
        dataProvider = MockWeatherDataProvider()
        viewModel = WeatherViewModel(withDataProvider: dataProvider)
    
        dataProvider.delegate = viewModel
        view.viewModel = viewModel
        view.bindViewModelOutput()
    }
    
    override func tearDown() {
        super.tearDown()
        dataProvider = nil
        viewModel = nil
    }
    
    func testFetchForecastMethod() {
        
        dataProvider.closure = { [unowned self] in
            let forecastday = try! JSONDecoder().decode(CurrentWeatherModel.self, from: forecastStub)
            self.dataProvider.delegate?.onSuccess(forecastday)
        }
        
        viewModel.fetchForecast(countery: "Alexandria")
        XCTAssert(viewModel.mainCity == "Alexandria")
        XCTAssert(viewModel.mainTemp == 67.5)
        XCTAssert(viewModel.wind == 7.6)
        XCTAssert(viewModel.humidity == 57)
        
        let cellViewModel = viewModel.getForecastCellViewModel(index: 0)
        XCTAssert(cellViewModel.temp == "65.5 / 72.9")
    }
    
    func testViewModelNumberOfItems() {
        dataProvider.closure = {  [unowned self] in
            let forecastday = try! JSONDecoder().decode(CurrentWeatherModel.self, from: forecastStub)
            self.dataProvider.delegate?.onSuccess(forecastday)
        }
        
        viewModel.fetchForecast(countery: "Alexandria")
        XCTAssert(viewModel.numberOfItems == 1)
        
    }
    
}
