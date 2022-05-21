//
//  Geocoding.swift
//  Weather
//
//  Created by Miro Rauhala on 21.5.2022.
//

import Foundation

struct Geocode: Identifiable, Decodable {
    var id = UUID()
    var name: String
    var local_names: Dictionary<String, String>?
    var lat: Double
    var lon: Double
    var country: String
    var state: String?
    
    private enum CodingKeys: String, CodingKey {
        case name,local_names,lat,lon,country,state
    }
}
