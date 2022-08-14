//
//  NetworkManager.swift
//  Weather
//
//  Created by Macbook Air on 11.08.2022.
//

import Foundation
import Alamofire

class NetworkManager {
    
    // MARK: - GET requesst for a week forecast
    func loadWeather(completionBlock: @escaping(([List]) -> Void)) {
        let url = "https://api.openweathermap.org/data/2.5/forecast?lat=47.90966&lon=33.38044&appid=0aba64c2425fb60681188b1bd53ab315&units=metric"
        AF.request(url).responseJSON { [weak self] results in
            do {
                guard let responseData = results.data else { return }
                let fetchedData = try JSONDecoder().decode(WeatherForecast.self, from: responseData)
                completionBlock(fetchedData.list ?? [])
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: - GET request for a day forecast
    func loadCurrentWeather(completionBlock: @escaping((CurrentWeatherForecast)->())) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=0aba64c2425fb60681188b1bd53ab315&units=metric"
        AF.request(url).responseJSON { [weak self] results in
            do {
                guard let responseData = results.data else { return }
                let fetchedData = try JSONDecoder().decode(CurrentWeatherForecast.self, from: responseData)
                completionBlock(fetchedData)
            } catch {
                print(error)
            }
            
        }
    }
    
}
