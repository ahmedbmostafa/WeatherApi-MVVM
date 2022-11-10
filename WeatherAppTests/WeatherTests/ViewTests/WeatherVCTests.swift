//
//  WeatherVCTests.swift
//  WeatherAppTests
//
//  Created by AhmedHD_SL on 10/11/2022.
//

import XCTest
@testable import WeatherApp

class WeatherVCTests: XCTestCase {

    var viewModel: MockWeatherViewModel!
    var view: WeatherVC!

    override func setUp() {
        super.setUp()
        viewModel = MockWeatherViewModel()
        view = WeatherVC.instantiate(fromAppStoryboard: .Main)
        view.viewModel = viewModel
        view.loadView()
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
        view = nil
    }

    func testNumberOfRowsInSection() {
        _ = view.collectionView(view.forecastCollectionView, numberOfItemsInSection: 1)
        XCTAssertTrue(viewModel.isNumberOfItemsCalls == true)
    }

}
