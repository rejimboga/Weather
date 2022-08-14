//
//  SearchViewModel.swift
//  Weather
//
//  Created by Macbook Air on 14.08.2022.
//

import Foundation
struct CityModel {
    var city: String
    var location: (lat: Double, long: Double)
}

class SearchViewModel {
    let cities = [CityModel(city: "Kyiv", location: (50.4546600, 30.5238000)),
                  CityModel(city: "Kriviy Rih", location: (47.9096600, 33.3804400)),
                  CityModel(city: "Odesa", location: (46.4774700, 30.7326200)),
                  CityModel(city: "Dnipro", location: (48.4500000, 34.9833300)),
                  CityModel(city: "Lviv", location: (49.8382600, 24.0232400))]
    
    var searchResult = [CityModel]()
    
}
