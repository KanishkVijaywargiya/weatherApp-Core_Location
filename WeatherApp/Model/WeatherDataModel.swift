//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Kanishk Vijaywargiya on 03/01/23.
//

import Foundation

struct WeatherDataModel: Codable {
    var name: String
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var wind: WindResponse
}

struct CoordinatesResponse: Codable {
    var lon, lat: Double
}

struct WeatherResponse: Codable {
    var id: Int
    var main: String
    var weatherDescription: String
    var icon: String
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

struct MainResponse: Codable {
    var temp: Double
    var feelsLike: Double
    var tempMin: Double
    var tempMax: Double
    var pressure: Double
    var humidity: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

struct WindResponse: Codable {
    var speed: Double
    var deg: Double
}
