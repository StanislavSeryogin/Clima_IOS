//
//  WeatherManager.swift
//  Clima_IOS
//
//  Created by Stanislav Seryogin on 02.08.2023.
//

import Foundation

class WeatherManager {
    let weatherURL = "http://api.openweathermap.org/data/2.5/weather"
    let weatherAPIKey = "bb7f17a8b8d4851f643f47e6049edd89"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)?appid=\(weatherAPIKey)&units=metric&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        // create URL
        if let url = URL(string: urlString) {
            // create URL session
            let session = URLSession(configuration: .default)
            // give the session task
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error)
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                }
            }
            // start the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedDate = try decoder.decode(WeatherDate.self, from: weatherData)
            let id = decodedDate.weather[0].id
            let temp = decodedDate.main.temp
            let name = decodedDate.name
            let weather = WeatherModel(condotionId: id, cityName: name, temp: temp)
            
            print(weather.tempString)
        } catch {
            print(error)
        }
    }
}

