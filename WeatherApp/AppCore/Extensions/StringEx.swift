//
//  StringEx.swift
//  WeatherApp
//
//  Created by AhmedHD_SL on 10/11/2022.
//

import Foundation


extension String {
    
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
    
    func convertDateGMT(from: String, to: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = from
//        formatter.timeZone = TimeZone(abbreviation: "UTC")
    
        guard let date = formatter.date(from: self) else {return ""}
        if Locale.current.languageCode == "ar"{
            formatter.locale = Locale(identifier: "ar")
        }
        formatter.dateFormat = to
        formatter.timeZone = TimeZone.current
        let timeStamp = formatter.string(from: date)
        return timeStamp
    }
}

