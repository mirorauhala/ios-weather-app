//
//  ContentView.swift
//  Weather
//
//  Created by Miro Rauhala on 19.5.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var api = OpenWeatherMap(unit: OpenWeatherMap.TemperatureFormat.Celsius)
    
    
    var body: some View {
        TabView {
            WeatherView(cities: $api.cities, unit: $api.unit)
                .tabItem {
                    Image(systemName: "sun.min")
                    Text("Weather")
                }.onAppear(perform: reloadWeather)
            
            SettingsView(api: api)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    
        
    }
    
    private func reloadWeather() {
        api.reloadWeather()
    }
}
