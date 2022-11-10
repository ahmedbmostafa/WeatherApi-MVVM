//
//  ForecastCellViewModel.swift
//  WeatherApp
//
//  Created by AhmedHD_SL on 10/11/2022.
//

import Foundation

class ForecastCellViewModel {
    
    var temp: String?
    var day: String?
    var path: String?
    var icon = [String]()
    var code: String?
    var text: String?
    var forecastday: Forecastday?
    
    
    init(_ forecastday: Forecastday?){
        self.temp = "\(forecastday?.day?.mintempF ?? 0) / " + "\(forecastday?.day?.maxtempF ?? 0)"
        self.day = self.getCurrentDate(forecastday: forecastday)
        self.icon = generateIcon(path: forecastday?.day?.condition?.icon ?? "")
    }
    
    private func getCurrentDate(forecastday: Forecastday?) -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let current = dateFormatter.string(from: date)
        let forcastDate = forecastday?.date ?? ""
        let nextDay = getNextDay()
        if current == forcastDate {
            return "Today"
        } else if nextDay == forcastDate {
            return "Tomorrow"
        } else {
            return (forecastday?.date ?? "").convertDateGMT(from: "yyyy-MM-dd", to: "EEEE")
        }
    }
    
    private func getNextDay() -> String{
        var dayComponent = DateComponents()
        dayComponent.day = 1
        let theCalendar = Calendar.current
        let nextDate = theCalendar.date(byAdding: dayComponent, to: Date())!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let nextDateStr = dateFormatter.string(from: nextDate)
        return nextDateStr
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
        self.code = iconCode
        self.text = text
        return fm.getListFileNameInBundle(bundlePath: "\(text).bundle")
    }
}
