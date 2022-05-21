//
//  ContentView.swift
//  Weather
//
//  Created by Miro Rauhala on 19.5.2022.
//

import SwiftUI

struct ContentView: View {
    @State var cities: [City] = [
        City(id: 1, name: "Tampere", temp: 22),
        City(id: 2, name: "Helsinki", temp: 10),
        City(id: 3, name: "Oulu", temp: -10)
    ]
    
    var body: some View {
        TabView {
            WeatherView(cities: $cities)
                .tabItem {
                    Image(systemName: "sun.min")
                    Text("Weather")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    
        
    }
}
