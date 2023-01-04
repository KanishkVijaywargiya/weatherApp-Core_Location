//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Kanishk Vijaywargiya on 03/01/23.
//

import Foundation

struct WeatherModel: Codable {
    let conditionId: Int
    let cityName: String
    let weatherName: String
    let temperature: Double
    let minTemp: Double
    let maxTemp: Double
    let humidity: Double
    let feelsLike: Double
    let windSpeed: Double
    
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
