//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Macbook Air on 11.08.2022.
//

import Foundation

struct ViewPresentedModel {
    var maxTemp: Double = 0.0
    var minTemp: Double = 0.0
    var date: Date = Date()
}

protocol WeatherViewModelProtocol {
    var weatherList: Observable<[List]?> { get }
    var resultArray: [ViewPresentedModel]? { get }
    
    func getWeather()
}

class WeatherViewModel: WeatherViewModelProtocol {
    var weatherList: Observable<[List]?> = Observable<[List]?>(nil)
    var resultArray: [ViewPresentedModel]? = [ViewPresentedModel]()
    
    var dict: [Date:[List]] = [:]
    init() {
        getWeather()
    }
    
    func getWeather() {
        NetworkManager().loadWeather { [weak self] dataWeather in
            DispatchQueue.main.async {
                self?.settingCurrentForecast(list: dataWeather)
                self?.filterForecastForNextDays()
            }
        }
        
    }
    
    private func settingCurrentForecast(list: [List]) {
        list.forEach({
            if !dict.keys.contains(($0.dtTxt?.toDate()!.startOfDay)!) {
                dict[($0.dtTxt?.toDate()!.startOfDay)!] = [$0]
            } else {
                dict[($0.dtTxt?.toDate()!.startOfDay)!]?.append($0)
            }
        })
        self.weatherList.value = dict[list.first?.dtTxt?.toDate()?.startOfDay ?? Date()]
    }
    
    private func filterForecastForNextDays() {
        var resultDict: [Date:(min: Double?, max: Double?)] = [:]
        dict.keys.forEach { date in
            let max = dict[date]?.compactMap({ $0.main?.tempMax }).max()
            let min = dict[date]?.compactMap({ $0.main?.tempMin }).min()
            resultDict[date] = (min: min, max: max)
        }
        
        
        self.resultArray = resultDict.map({ ViewPresentedModel(maxTemp: $0.value.max ?? 0.0, minTemp: $0.value.min ?? 0.0, date: $0.key) }).sorted(by: {$0.date < $1.date})
    }
    
}


