//
//  OpenWeatherMap.swift
//  Weather
//
//  Created by Miro Rauhala on 21.5.2022.
//

import Foundation
import Alamofire

class OpenWeatherMap: ObservableObject {
    private let ENDPOINT = "https://api.openweathermap.org"
    private let API_KEY = "d6bde17f9f8632d69dbbb337b20dd698" // most likely there's a better way
    
    enum TemperatureFormat: String {
        case Celsius = "metric"
        case Fahrenheit = "imperial"
        case Kelvin = ""
    }
    
    @Published var cities: [City] = []
    @Published var unit: TemperatureFormat
    
    init(unit: TemperatureFormat) {
        self.unit = unit

    }
    
    ///
    /// This function is used for searching cities.
    ///
    func search(_ query: String, _ action: @escaping (_ response: [Geocode]) -> Void) {
        let parameters: [String: String] = [
            "q": query,
            "limit": String(5),
            "appid": API_KEY
        ]
        
        AF.request(ENDPOINT + "/geo/1.0/direct", parameters: parameters).responseDecodable(of: [Geocode].self) {
            response in
            debugPrint(response)

            guard let cities: [Geocode] = response.value else {return }
            debugPrint("ran the geo search")
            action(cities)
        }
    }
    
    ///
    /// This function is used to fetch the temperature for a given city with coordinates.
    ///
    func getWeather(lat: Double, lon: Double, format: TemperatureFormat, _ action: @escaping (City) -> Void) {
        let parameters: [String: String] = [
            "lat": String(lat),
            "lon": String(lon),
            "units": format.rawValue,
            "appid": API_KEY
        ]
            
        AF.request(ENDPOINT + "/data/2.5/weather", parameters: parameters).responseDecodable(of: City.self) {
            response in
            guard let city = response.value else {return }
            action(city)
            
        }
    }
    
    ///
    /// This function is called when the weather view appears to reload all the temperatures to up-to-date values.
    ///
    func reloadWeather() {
        let copyOfCities = cities
        cities = []
         
        copyOfCities.forEach { city in
            //getWeather(lat: 61.4980214, lon: 23.7603118, format: unit)
            getWeather(lat: city.coord.lat, lon: city.coord.lon, format: unit) { city in
                self.cities.append(city)
            }
        }
    }
    
    ///
    /// This function returns the single letter symbol representing the current temperature format.
    ///
    static func getTempSymbol(_ format: TemperatureFormat) -> String {
        switch(format) {
        case .Celsius:
            return "C"
        case .Fahrenheit:
            return "F"
        case .Kelvin:
            return "K"
        }
    }
}

