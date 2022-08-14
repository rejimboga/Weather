//
//  DateExtension.swift
//  Weather
//
//  Created by Macbook Air on 13.08.2022.
//

import Foundation

extension Date {
    func currentDay() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, d MMMM"
        return (dateFormatter.string(from: date))
    }
    
    func dayWeek() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return (dateFormatter.string(from: date))
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    func toDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return (dateFormatter.string(from: self))
    }
    
}
