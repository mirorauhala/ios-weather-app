//
//  CityCard.swift
//  Weather
//
//  Created by Miro Rauhala on 21.5.2022.
//

import SwiftUI

struct CityCard: View {
    @Binding var city: City
    
    var body : some View {
        HStack {
            VStack(alignment: .leading) {
                Spacer()
                Text(city.name).font(.subheadline)
                Text("\(city.temp)").font(.largeTitle)
                Spacer()
            }
            Spacer()
            VStack(alignment: .trailing) {
                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/01d@2x.png"), scale: 1)
                    .frame(width: 100, height: 100)
            }
        }
    }
}
