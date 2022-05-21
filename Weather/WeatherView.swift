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
    @ObservedObject var api: OpenWeatherMap
    
    var body : some View {
        NavigationView {
            VStack {
                if $api.cities.isEmpty {
                    Text("Add a city")
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(.systemGroupedBackground))
                } else {
                    List {
                        ForEach($api.cities) {city in
                            CityCard(city: city, unit: $api.unit)
                        }
                        .onDelete(perform: onDelete)
                    }
                }
            }
            .navigationBarTitle("Weather")
            .navigationBarItems(leading: editButton, trailing: addButton)
            .environment(\.editMode, $editMode)
            .sheet(isPresented: $isAddCitySheetOpen) {
                SearchSheet(api: api, isPresented: $isAddCitySheetOpen)
            }
        }
    }
    
    /// This function deletes cities from the list
    private func onDelete(offsets: IndexSet) {
        api.cities.remove(atOffsets: offsets)
    }
    
    /// This function shows the EditButton when available
    private var editButton: some View {
        if $api.cities.isEmpty {
            return AnyView(EmptyView())
        } else {
            return AnyView(EditButton())
        }
    }

    /// This function shows the button for adding when available
    private var addButton: some View {
        switch editMode {
        case .inactive:
            return AnyView(Button(action: onAdd) { Image(systemName: "plus") })
        default:
            return AnyView(EmptyView())
        }
    }

    
    /// This function is called when Add button is tapped
    func onAdd() {
        isAddCitySheetOpen.toggle()
    }

}
