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

    @Binding var cities : [City]
    
    var body : some View {
        NavigationView {
            List {
                ForEach($cities) {city in
                    CityCard(city: city)
                }
                .onDelete(perform: onDelete)
                .onMove(perform: onMove)
            }
            .navigationBarItems(leading: EditButton(), trailing: addButton)
            .navigationBarTitle("Weather")
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
