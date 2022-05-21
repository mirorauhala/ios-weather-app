//
//  SearchSheet.swift
//  Weather
//
//  Created by Miro Rauhala on 21.5.2022.
//

import SwiftUI

struct SearchSheet: View {
    @Binding var search: String
    @Binding var searchResults: [City]
    
    var body: some View {
        Form {
            TextField("Search", text: $search)
            Section {
                List {
                    ForEach(searchResults) { city in
                        Text(city.name).tag(city.id)
                    }
                }
            }
        }
    }
}
