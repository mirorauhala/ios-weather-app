//
//  SettingsView.swift
//  Weather
//
//  Created by Miro Rauhala on 20.5.2022.
//

import SwiftUI

struct SettingsView : View {
    @ObservedObject var api: OpenWeatherMap
    
    var body : some View {
        NavigationView {
            List {
                Picker("Format", selection: $api.unit) {
                    Text("Celsius").tag(OpenWeatherMap.TemperatureFormat.Celsius)
                    Text("Fahrenheit").tag(OpenWeatherMap.TemperatureFormat.Fahrenheit)
                    Text("Kelvin").tag(OpenWeatherMap.TemperatureFormat.Kelvin)
                }
            }.navigationTitle("Settings")
        }
    }
}
