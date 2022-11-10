//
//  WeatherBuilderTests.swift
//  WeatherAppTests
//
//  Created by AhmedHD_SL on 10/11/2022.
//

import XCTest
@testable import WeatherApp

class WeatherBuilderTests: XCTestCase {

    var view: WeatherVC!
    var appFlowManager: AppFlowManager!

    override func setUp() {
        super.setUp()
        appFlowManager = AppFlowManager()
        view = appFlowManager.creatWeatherVC() as! WeatherVC
    }

    override func tearDown() {
        super.tearDown()
        view = nil
    }

    func testBuildViewModel() {
        XCTAssertTrue(view.viewModel != nil)
        XCTAssertTrue(view.viewModel.dataProvider != nil)
    }

    func testBuildVC() {
        XCTAssertTrue(view != nil)
    }


}
