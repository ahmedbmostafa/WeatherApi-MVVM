//
//  MockWeatherVC.swift
//  WeatherAppTests
//
//  Created by AhmedHD_SL on 10/11/2022.
//

import XCTest
@testable import WeatherApp

class MockWeatherVC: WeatherVC {
    
    var isReloadNewsCalls = false
    var isShowLoaderCalls = false
    var isSetMainTime = false
    var isSetMainCity = false
    var isSetMainDate = false
    var isSetMainIcon = false
    var isSetMainTemp = false
    var isSetMainWind = false
    var isSetMainHumidity = false
    var isSetDayDescription = false
    
    
    var isShowErrorCalls = false
    
    override func bindViewModelOutput() {
        viewModel.output = { [weak self] output in
            guard let self = self else { return }
            switch output {
            case .updateForecasrData( _):
                self.isReloadNewsCalls = true
                
            case .mainTime( _):
                self.isSetMainTime = true
                
            case .mainCity( _):
                self.isSetMainCity = true
                
            case .mainDate( _):
                self.isSetMainDate = true
                
            case .mainIcon( _):
                self.isSetMainIcon = true
                
            case .mainTemp( _):
                self.isSetMainTemp = true
                
            case .mainWind( _):
                self.isSetMainWind = true
                
            case .mainHumidity( _):
                self.isSetMainHumidity = true
                
            case .dayDescription( _):
                self.isSetDayDescription = true
                
            case .showActivityIndicator( _):
                self.isShowLoaderCalls = true
                
            case .showError( _):
                self.isShowErrorCalls = true
                
            }
        }
    }
    
}
