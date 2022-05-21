//
//  Cities.swift
//  Weather
//
//  Created by Miro Rauhala on 20.5.2022.
//

import Foundation

struct City : Identifiable, Hashable {
    var id : Int
    var name : String
    var temp : Int
}
