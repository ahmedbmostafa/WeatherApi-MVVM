//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by AhmedHD_SL on 08/11/2022.
//

import Foundation


// MARK: - Welcome
struct CurrentWeatherModel: Codable {
    let location: LocationModel?
    let current: CurrentModel?
    let forecast: Forecast?
}

// MARK: - Current
struct CurrentModel: Codable {
    let lastUpdatedEpoch: Double?
    let lastUpdated: String?
    let tempF: Double?
    let condition: Condition?
    let windMph: Double?
    let  humidity: Double?
    
    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempF = "temp_f"
        case condition
        case windMph = "wind_mph"
        case humidity
    }
}

// MARK: - Condition
struct Condition: Codable {
    let text: String?
    let icon: String?
    let code: Int?
}

// MARK: - Location
struct LocationModel: Codable {
    let name, region, country: String?
    let lat, lon: Double?
    let tzID: String?
    let localtimeEpoch: Int?
    let localtime: String?
    
    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzID = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}


// MARK: - Forecast
struct Forecast: Codable {
    let forecastday: [Forecastday]?
}

// MARK: - Forecastday
struct Forecastday: Codable {
    let date: String?
    let day: Day?
}

// MARK: - Day
struct Day: Codable {
    let maxtempF, mintempF: Double?
    let condition: Condition?
    
    enum CodingKeys: String, CodingKey {
        case maxtempF = "maxtemp_f"
        case mintempF = "mintemp_f"
        case condition
    }
}
