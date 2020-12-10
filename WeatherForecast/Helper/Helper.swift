//
//  Helper.swift
//  WeatherForecast
//
//  Created by MacBook Pro on 12/7/20.
//  Copyright © 2020 MailMedia. All rights reserved.
//

import Foundation
 
func getDateFromTimeStamp(_ timeStamp : Double) -> String {
    let date = Date(timeIntervalSince1970: timeStamp)
    let dayTimePeriodFormatter = DateFormatter()
    dayTimePeriodFormatter.dateFormat = "EEEE,MMMM dd"
    let dateString = dayTimePeriodFormatter.string(from: date as Date)
    return dateString
}

func getTimeFromTimeStamp(_ timeStamp : Double) -> String {
    let date = Date(timeIntervalSince1970: timeStamp)
    let dayTimePeriodFormatter = DateFormatter()
    dayTimePeriodFormatter.dateFormat = "HH"
    let dateString = dayTimePeriodFormatter.string(from: date as Date)
    return dateString
}
 
func getDayFromTimeStamp(_ timeStamp : Double) -> String {
    let date = Date(timeIntervalSince1970: timeStamp)
    let dayTimePeriodFormatter = DateFormatter()
    dayTimePeriodFormatter.dateFormat = "dd"
    let dateString = dayTimePeriodFormatter.string(from: date as Date)
    return dateString
}

func fromKelvinToCelsius(_ kelvin:Double) -> String {
    let res = kelvin - 273.15
    return String(Int(res)) + "°"
}
