//
//  WeatherError.swift
//  Weather-iOS-App
//
//  Created by Claudine Callaghan on 11/09/2018.
//  Copyright © 2018 Claudine Callaghan. All rights reserved.
//

import Foundation

enum WeatherError: Error {
    case requestFailed
    case responseUnsuccessful (status: Int)
    case invalidData
    case jsonParseFailure
    case invalidUrl
}
















