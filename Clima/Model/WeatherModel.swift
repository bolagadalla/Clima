//
//  WeatherModel.swift
//  Clima
//
//  Created by Bola Gadalla on 23/11/19.
//  Copyright © 2019 Bola Gadalla. All rights reserved.
//

import Foundation

struct WeatherModel
{
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String
    {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String
    {
        switch conditionID
        {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 801...804:
            return "cloud"
        case 701:
            return "smoke.fill"
        case 711:
            return "smoke"
        case 721:
            return "sun.haze"
        case 731:
            return "sun.dust"
        case 741:
            return "cloud.fog"
        case 751:
            return "smoke"
        case 761:
            return "sun.dust"
        case 762:
            return "smoke"
        case 771:
            return "wind"
        case 781:
            return "tornado"
        default: //800
            return "sun.max"
        }
    }
}
