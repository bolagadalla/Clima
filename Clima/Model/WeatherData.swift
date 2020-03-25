//
//  WeatherData.swift
//  Clima
//
//  Created by Bola Gadalla on 23/11/19.
//  Copyright © 2019 Bola Gadalla. All rights reserved.
//

import Foundation

struct WeatherData: Decodable
{
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable
{
    let temp: Double
    let pressure: Int
    let humidity: Int
    let temp_min: Double
    let temp_max: Double
}

struct Weather: Decodable
{
    let id: Int
    let main: String
    let description: String
}
