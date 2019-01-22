//
//  ForecastService.swift
//  Weathery
//
//  Created by Gerasim Israyelyan on 1/22/19.
//  Copyright © 2019 Gerasim Israyelyan. All rights reserved.
//

import Foundation

class ForecastService {
    
    let forecastAPIKey: String
    let forecastBaseURL: URL?

    init(APIKey: String) {
        self.forecastAPIKey = APIKey
        forecastBaseURL = URL(string: "https://api.darksky.net/forecast/\(APIKey)")
    }
    
    func getForecast(latitude: Double, longitudude: Double, completion: @escaping (CurrentWeather?) -> Void) {
        
        if let forecastUrl = URL(string: "\(forecastBaseURL!)/\(latitude),\(longitudude)" ) {
            let networkProcessor = NetworkProcessor(url: forecastUrl)
            networkProcessor.downloadJSONFromUrl { (jsonDictonay) in
                if let currentWeatherDictonary = jsonDictonay?["currently"] as? [String : Any] {
                    let currentWeather = CurrentWeather(weatherDictonary: currentWeatherDictonary)
                    completion(currentWeather)
                } else {
                    completion(nil)
                }
            }
        }
    }
}

