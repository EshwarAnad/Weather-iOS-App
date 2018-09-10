//
//  CurrentWeatherViewModel.swift
//  Weather-iOS-App
//
//  Created by Claudine Callaghan on 10/09/2018.
//  Copyright © 2018 Claudine Callaghan. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeatherViewModel {
    let temperature: String
    let humidity: String
    let precipitationProbability: String
    let summary: String
    let icon: UIImage

    
    init(model: CurrentWeather) {
        //converts Fahrenheit to Celcius and rounds number.
        let roundedTemperature = Int(5.0 / 9.0 * (model.temperature - 32.0))
        self.temperature = "\(roundedTemperature)º"
        
        let humidityPercentValue = Int(model.humidity * 100)
        self.humidity = "\(humidityPercentValue)%"
        
        let precipitationPercentValue = Int(model.precipProbability * 100)
        self.precipitationProbability = "\(precipitationPercentValue)%"
        
        self.summary = model.summary
        
        //Should not be in the ViewModel? 
        self.icon = model.iconImage
    }
}

