//
//  WeatherDate.swift
//  Clima_IOS
//
//  Created by Stanislav Seryogin on 03.08.2023.
//

import Foundation

struct WeatherDate: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
}
