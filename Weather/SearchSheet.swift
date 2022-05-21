//
//  SearchSheet.swift
//  Weather
//
//  Created by Miro Rauhala on 21.5.2022.
//

import SwiftUI

struct SearchSheet: View {
    @ObservedObject var api: OpenWeatherMap
    @Binding var isPresented: Bool
    @State var query: String = ""
    @State var searchResults: [Geocode] = []
    
    var body: some View {
        Form {
            TextField("Search", text: $query)
            Section {
                List {
                    ForEach(searchResults) { city in
                        Button("\(city.name), \(city.country)", action: {
                            
                            // when the button is tapped, get the city and push it to the api.cities list
                            api.getWeather(lat: city.lat, lon: city.lon, format: api.unit) { responseCity in
                                api.cities.insert(responseCity, at: 0)
                                isPresented = false
                            }
                        }).tag(city.id)
                    }
                }
            }
        }.onSubmit {
            
            // Submit the search request and show the cities from the response
            api.search(query) { cities in
                searchResults = cities
            }
        }
    }
}
