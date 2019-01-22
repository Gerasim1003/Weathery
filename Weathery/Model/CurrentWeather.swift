//
//  CurrentWeather.swift
//  Weathery
//
//  Created by Gerasim Israyelyan on 1/22/19.
//  Copyright © 2019 Gerasim Israyelyan. All rights reserved.
//

import Foundation

class CurrentWeather {
    
    let temperature: Int?
    let humidity: Int?
    let precipProbability: Int?
    let summary: String?
    
    struct WeatherKeys {
        static let temperature = "temperature"
        static let humidity = "humidity"
        static let precipProbability = "precipProbability"
        static let summary = "summary"
    }
    
    init(weatherDictonary: [String : Any]) {
        temperature = Int( ( (weatherDictonary[WeatherKeys.temperature] as? Double)! - 32 ) / 1.8 )
        
        if let humidityDouble = weatherDictonary[WeatherKeys.humidity] as? Double {
            humidity = Int(humidityDouble * 100)
        } else {
            humidity = nil
        }
        
        if let precipDouble = weatherDictonary[WeatherKeys.precipProbability] as? Double {
            precipProbability = Int(precipDouble * 100)
        } else {
            precipProbability = nil
        }
        
        summary = weatherDictonary[WeatherKeys.summary] as? String
    }
}
