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
            WeatherView(api: api)
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
    
    /// This function is called when WeatherView appears
    private func reloadWeather() {
        api.reloadWeather()
    }
}
