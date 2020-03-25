//
//  WeatherManager.swift
//  Clima
//
//  Created by Bola Gadalla on 23/11/19.
//  Copyright © 2019 Bola Gadalla. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate
{
    func DidUpdateWeather(weatherManager: WeatherManager, weather: WeatherModel)
    func DidFailWithError(error: Error)
}

struct WeatherManager
{
    var delegate: WeatherManagerDelegate?
    
    let URLstring = "https://api.openweathermap.org/data/2.5/weather?appid=7cabb57bf33bccb4f4e1b9de0ce6e461&units=imperial"
            
    func GetWeatherData(cityName: String)
    {
        let URLString = "\(URLstring)&q=\(cityName)"
        PerformRequest(urlString: URLString)
    }
    
    func FetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    {
        let URLString = "\(URLstring)&lat=\(latitude)&lon=\(longitude)"
        PerformRequest(urlString: URLString)
    }
    
    func PerformRequest(urlString: String)
    {
        if let url = URL(string: urlString)
        {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil
                {
                    self.delegate?.DidFailWithError(error: error!)
                    return
                }
                
                if let safeData = data
                {
                    if let weather = self.ParseJSON(weatherData: safeData)
                    {
                        self.delegate?.DidUpdateWeather(weatherManager: self, weather: weather)
                    }
                }
            })
            task.resume()
        }
    }
    
    func ParseJSON(weatherData: Data) -> WeatherModel?
    {
        let decoder = JSONDecoder()
        do
        {
           let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let cityName = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(conditionID: id, cityName: cityName, temperature: temp)
            return weather
        }
        catch
        {
            delegate?.DidFailWithError(error: error)
            return nil
        }
    }
}
