//
//  CurrentWeather.swift
//  Weather-iOS-App
//
//  Created by Claudine Callaghan on 10/09/2018.
//  Copyright © 2018 Claudine Callaghan. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeather {
    let temperature: Double
    let humidity: Double
    let precipProbability: Double
    let summary: String
    let icon: String
}

extension CurrentWeather {
    var iconImage: UIImage {
        return UIImage(imageLiteralResourceName: icon)
    }
    
}
