//
//  AppFlowManager.swift
//  WeatherApp
//
//  Created by AhmedHD_SL on 08/11/2022.
//

import UIKit


class AppFlowManager {

    func start(navigationController: UINavigationController) {
        let vc = creatWeatherVC()
        navigationController.pushViewController(vc, animated: false)
    }
}

extension AppFlowManager {

    func creatWeatherVC() -> UIViewController {
        let weatherVC = WeatherVC.instantiate(fromAppStoryboard: .Main)
        let dataProvider = WeatherDataProviderImpl()
        dataProvider.weatherService = WeatherServiceImp()
        let viewModel = WeatherViewModel(withDataProvider: dataProvider)
        dataProvider.delegate = viewModel
        viewModel.dataProvider = dataProvider
        weatherVC.viewModel = viewModel
        return weatherVC
    }

}
