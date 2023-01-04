//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Kanishk Vijaywargiya on 03/01/23.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var vm = CurrentWeatherViewModel()
    @State private var searchCity: String = ""
    
    var body: some View {
        ZStack (alignment: .leading) {
            VStack {
                searchField //search field
                cityName //city name
                Spacer()
                tempAndImageSection //temp, image
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            VStack {
                Spacer()
                weatherData //weather stats
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(
            Color(hue: 0.656, saturation: 0.787, brightness: 0.354)
        )
        .preferredColorScheme(.dark)
        .onAppear {
            vm.fetchWeather()
        }
    }
}
struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
extension WeatherView {
    private var cityName: some View {
        VStack (alignment: .leading, spacing: 5) {
            if let currentWeather = vm.weather {
                Text(currentWeather.cityName)
                    .font(.title.bold())
            }
            Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                .fontWeight(.light)
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var tempAndImageSection: some View {
        VStack {
            if let currentWeather = vm.weather {
                HStack {
                    VStack(spacing: 20) {
                        Image(systemName: currentWeather.conditionName).font(.system(size: 40))
                        Text(currentWeather.weatherName)
                    }
                    .frame(width: 150, alignment: .leading)
                    Spacer()
                    Text(currentWeather.temperature.roundDouble + "°C")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .padding()
                }.padding(.top, 20)
            }
            Spacer().frame(height: 40)
            AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 350)
            } placeholder: {
                LoadingView()
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    private var weatherData: some View {
        VStack (alignment: .leading, spacing: 20) {
            Text("Weather now").font(.title.bold()).padding(.bottom)
            if let currentWeather = vm.weather {
                HStack {
                    WeatherRow(logo: "thermometer", name: "Min Temp", value: (currentWeather.minTemp.roundDouble + ("°C")))
                    Spacer()
                    WeatherRow(logo: "thermometer", name: "Max Temp", value: (currentWeather.maxTemp.roundDouble + ("°C")))
                }
                HStack {
                    WeatherRow(logo: "wind", name: "Wind Speed", value: currentWeather.windSpeed.roundDouble + "m/s")
                    Spacer()
                    WeatherRow(logo: "humidity", name: "Humidity", value: currentWeather.humidity.roundDouble + "%")
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .padding(.bottom, 20)
        .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .background(.white)
        .cornerRadius(20, corners: [.topLeft, .topRight])
    }
    
    private var searchField: some View {
        HStack (spacing: 20) {
            ImageLogo(logo: "location.fill", action: {
                print("Hello u pressed")
                vm.fetchWeather()
            })
            //type city name to get weather data
            SearchBar(text: $searchCity, action: {})
        }.padding(.bottom)
    }
}
