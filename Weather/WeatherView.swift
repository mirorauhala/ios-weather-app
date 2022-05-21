//
//  CityCard.swift
//  Weather
//
//  Created by Miro Rauhala on 20.5.2022.
//

import SwiftUI

struct WeatherView : View {
    @State private var editMode = EditMode.inactive
    @State private var isAddCitySheetOpen = false
    @State private var search = ""
    @State private var searchResults: [City] = []

    @Binding var cities: [City]
    @Binding var unit: OpenWeatherMap.TemperatureFormat
    
    var body : some View {
        NavigationView {
            VStack {
                if $cities.isEmpty {
                    Text("Add a city")
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(.systemGroupedBackground))
                } else {
                    List {
                        ForEach($cities) {city in
                            CityCard(city: city, unit: $unit)
                        }
                        .onDelete(perform: onDelete)
                        .onMove(perform: onMove)
                    }
                    
                    
                }
            }
            
            .navigationBarTitle("Weather")
            .navigationBarItems(leading: editButton, trailing: addButton)
            .environment(\.editMode, $editMode)
            .sheet(isPresented: $isAddCitySheetOpen) {
                SearchSheet(search: $search, searchResults: $searchResults)
            }
        }
    }
    
    private func onDelete(offsets: IndexSet) {
        cities.remove(atOffsets: offsets)
    }

    private func onMove(source: IndexSet, destination: Int) {
        cities.move(fromOffsets: source, toOffset: destination)
    }
    
    private var editButton: some View {
        if $cities.isEmpty {
            return AnyView(EmptyView())
        } else {
            return AnyView(EditButton())
        }
    }

    private var addButton: some View {
        switch editMode {
        case .inactive:
            return AnyView(Button(action: onAdd) { Image(systemName: "plus") })
        default:
            return AnyView(EmptyView())
        }
    }

    func onAdd() {
        isAddCitySheetOpen.toggle()
        // To be implemented in the next section
    }

}
