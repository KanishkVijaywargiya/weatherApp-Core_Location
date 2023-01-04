//
//  CurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by Kanishk Vijaywargiya on 04/01/23.
//

import Foundation
import CoreLocation

class CurrentWeatherViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=0322b0b712d32815754d25da03692629&units=metric"
    private let manager = CLLocationManager()
    @Published var isLoading: Bool = false
    @Published var weather: WeatherModel?
    
    override init() {
        super.init()
        manager.delegate = self
        self.requestLocations()
    }
    
    private func requestLocations() {
        isLoading = true
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.fetchWeather()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error---->", error.localizedDescription)
        let weather = WeatherModel(conditionId: 741, cityName: "Nagpur", weatherName: "Fog", temperature: 18.01, minTemp: 18.01, maxTemp: 18.01, humidity: 82, feelsLike: 18.09, windSpeed: 1.03)
        DispatchQueue.main.async {[weak self] in
            self?.weather = weather
        }
    }
    
    func fetchWeather() {
        guard let location = manager.location else {
            self.requestLocations()
            return
        }
        let urlString = "\(weatherURL)&lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)"
        performRequest(urlString: urlString) { returnedData in
            self.parseJSON(returnedData)
        }
    }
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString) { returnedData in
            self.parseJSON(returnedData)
        }
    }
    
    private func performRequest(urlString: String, completionHandler: @escaping(_ data: Data?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        //2 Create an URLSession & 3. Give an URLSession a Task & 4 Start the Task
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300
            else {
                print("Error downloading data")
                completionHandler(nil)
                return
            }
            completionHandler(data)
        }.resume()
    }
    
    func parseJSON(_ returnedData: Data?) {
        if let data = returnedData {
            print(String(data: data, encoding: .utf8)!)
            guard let decodedData = try? JSONDecoder().decode(WeatherDataModel.self, from: data) else { return }
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let weatherName = decodedData.weather[0].main
            let temp = decodedData.main.temp
            let minTemp = decodedData.main.tempMin
            let maxTemp = decodedData.main.tempMax
            let humidity = decodedData.main.humidity
            let feelsLike = decodedData.main.feelsLike
            let windSpeed = decodedData.wind.speed
            let weather = WeatherModel(conditionId: id, cityName: name, weatherName: weatherName, temperature: temp, minTemp: minTemp, maxTemp: maxTemp, humidity: humidity, feelsLike: feelsLike, windSpeed: windSpeed)
            DispatchQueue.main.async {[weak self] in
                self?.weather = weather
            }
        }
    }
}
