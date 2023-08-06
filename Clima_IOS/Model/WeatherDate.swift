//
//  WeatherDate.swift
//  Clima_IOS
//
//  Created by Stanislav Seryogin on 03.08.2023.
//

import Foundation

struct WeatherDate: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
