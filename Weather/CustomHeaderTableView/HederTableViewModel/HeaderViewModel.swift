//
//  HeaderViewModel.swift
//  Weather
//
//  Created by Macbook Air on 11.08.2022.
//

import Foundation
protocol HeaderViewModelProtocol {
    var currentWeather: Observable<CurrentWeatherForecast?> { get }
    
    func getCurrentWeather()
}

class HeaderViewModel: HeaderViewModelProtocol {
    var currentWeather: Observable<CurrentWeatherForecast?> = Observable<CurrentWeatherForecast?>(nil)
    var weatherList: [List]?
    var location: CityModel?
    
    func getCurrentWeather() {
        DispatchQueue.main.async {
            NetworkManager().loadCurrentWeather { [weak self] dataWeather in
                self?.currentWeather.value = dataWeather
            }
        }
    }
    
    func numberOfItems() -> Int {
        return self.weatherList?.count ?? 0
    }
}

