//
//  JSONDownloader.swift
//  Weather-iOS-App
//
//  Created by Claudine Callaghan on 10/09/2018.
//  Copyright © 2018 Claudine Callaghan. All rights reserved.
//

import Foundation

class JSONDownloader{
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration){
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    typealias JSON = [String: AnyObject]
    typealias JSONTaskCompletionHandler = (JSON?, WeatherError?) -> Void
    
    func jsonTask(with request: URLRequest, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        
        let datatask = session.dataTask(with: request, completionHandler: {data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else{
                completion(nil, .requestFailed)
                return
            }
            
            if httpResponse.statusCode == 200 {
                //TODO: refactor
                //because the error object could be empty even when the data is nil
                // so check if we have valid data object
                if let data = data{
                    do{
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON
                        completion(json, nil)
                    }
                    catch{
                        completion(nil, .jsonParseFailure)
                    }
                    
                }else{ //if we dont then we check for an error
                    completion(nil, .invalidData)
                }
                
            } else {
                completion(nil, .responseUnsuccessful(status: httpResponse.statusCode))
            }
        })
        
        return datatask
    }
}















