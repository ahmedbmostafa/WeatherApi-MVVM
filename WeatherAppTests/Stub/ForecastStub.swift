//
//  ForecastStub.swift
//  WeatherAppTests
//
//  Created by AhmedHD_SL on 10/11/2022.
//

import Foundation

let forecastStub = "{\"location\":{\"name\": \"Alexandria\",\"region\": \"Al Iskandariyah\",\"country\": \"Egypt\",\"lat\": 31.2,\"lon\": 29.92,\"tz_id\": \"Cairo\",\"localtime_epoch\": 1668037310,\"localtime\": \"2022-11-10 1:41\"}, \"current\":{\"last_updated_epoch\": 1668036600,\"last_updated\": \"2022-11-10 01:30\",\"temp_f\": 67.5,\"condition\": { \"text\": \"Clear\", \"icon\": \"//cdn.weatherapi.com/weather/64x64/night/113.png\",\"code\": 1000},\"wind_mph\": 7.6,\"humidity\": 57}, \"forecast\":{\"forecastday\":[{\"date\":\"2022-11-10\",\"day\": {\"maxtemp_f\": 72.9,\"mintemp_f\": 65.5,\"condition\": {\"text\": \"Patchy rain possible\",\"icon\": \"//cdn.weatherapi.com/weather/64x64/day/176.png\",\"code\": 1063}}}]}}".data(using: .utf8)!
