//
//  WeatherAPIClient.swift
//  Weather-iOS-App
//
//  Created by Claudine Callaghan on 11/09/2018.
//  Copyright © 2018 Claudine Callaghan. All rights reserved.
//

import Foundation

class WeatherAPIClient {
    
    fileprivate let DarkSkyAPIKey = "9769eda4d2f9e7ba1b1e7d1789af309a"
    
    lazy var baseURL: URL = {
        URL(string: "https://api.darksky.net/forecast/\(self.DarkSkyAPIKey)/")!
    }()
    
    let decoder = JSONDecoder()
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    typealias WeatherCompletionHandler = (Weather?, Error?) -> Void
    typealias CurrentWeatherCompletionHandler = (Weather?, Error?) -> Void
    
    private func getWeather(at coordinate: Coordinate, completionHandler completion: @escaping WeatherCompletionHandler) {
        
        guard let url = URL(string: coordinate.description, relativeTo: baseURL) else {
            completion(nil, WeatherError.invalidUrl)
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) {data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(nil, WeatherError.requestFailed)
                        return
                    }
                    if httpResponse.statusCode == 200 {
                        do {
                            let weather = try self.decoder.decode(Weather.self, from: data)
                            completion(weather, nil)
                        } catch let error {
                            completion(nil, error)
                        }
                    } else {
                        completion(nil, WeatherError.invalidData)
                    }
                } else if let error = error {
                    completion(nil, error)
                }
            }
        }
        
        task.resume()
    }
    
    func getCurrentWeather(at coordinate: Coordinate, completionHandler completion: @escaping CurrentWeatherCompletionHandler) {
        getCurrentWeather(at: coordinate) { weather, error in
            completion(Weather?.currently, error)
        }
    }


}

















