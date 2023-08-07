//
//  WeatherManager.swift
//  Clima_IOS
//
//  Created by Stanislav Seryogin on 02.08.2023.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegeta {
    func didUpdeteWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

class WeatherManager {
    let weatherURL = "http://api.openweathermap.org/data/2.5/weather"
    let weatherAPIKey = "bb7f17a8b8d4851f643f47e6049edd89"
    
    var delegate: WeatherManagerDelegeta?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)?appid=\(weatherAPIKey)&units=metric&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latidude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)?appid=\(weatherAPIKey)&units=metric&lat=\(latidude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        // create URL
        if let url = URL(string: urlString) {
            // create URL session
            let session = URLSession(configuration: .default)
            // give the session task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdeteWeather(self, weather: weather)
                    }
                }
            }
            // start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedDate = try decoder.decode(WeatherDate.self, from: weatherData)
            let id = decodedDate.weather[0].id
            let temp = decodedDate.main.temp
            let name = decodedDate.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temp: temp)
            return weather
        
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}

