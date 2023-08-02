//
//  WeatherManager.swift
//  Clima_IOS
//
//  Created by Stanislav Seryogin on 02.08.2023.
//

import Foundation

class WeatherManager{
    let weatherURL = "http://api.openweathermap.org/data/2.5/weather"
    let weatherAPIKey = "bb7f17a8b8d4851f643f47e6049edd89"
    
    func featchWeather(cityName: String) {
        let urlString = "\(weatherURL)?appid=\(weatherAPIKey)&units=metric&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        // create URL
        if let url = URL(string: urlString) {
            // create URL session
            let session = URLSession(configuration: .default)
            // give the session task
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            // start the task
            task.resume()
        }
    }

    func handle(data: Data?, response: URLResponse?, error: Error?) {
        if let error = error {
            print(error)
            return
        }
        
        if let safeDta = data {
            let dataString = String(data: safeDta, encoding: .utf8)
            print(dataString as Any)
        }
    }

}
