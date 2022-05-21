//
//  SettingsView.swift
//  Weather
//
//  Created by Miro Rauhala on 20.5.2022.
//

import SwiftUI

struct SettingsView : View {
    @State private var selectedFormat: String = ""
    
    var body : some View {
        NavigationView {
            List {
                Picker("Format", selection: $selectedFormat) {
                    Text("Celsius").tag("metric")
                    Text("Fahrenheit").tag("imperial")
                    Text("Kelvin").tag("")
                }
            }.navigationTitle("Settings")
        }
    }
}
