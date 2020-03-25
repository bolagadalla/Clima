//
//  ViewController.swift
//  Clima
//
//  Created by Bola Gadalla on 23/11/19.
//  Copyright © 2019 Bola Gadalla. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController
{

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextInput: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        searchTextInput.delegate = self
        weatherManager.delegate = self
    }
    @IBAction func LocateButtonPressed(_ sender: UIButton)
    {
        locationManager.requestLocation()
    }
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate
{
    @IBAction func SearchButtonPressed(_ sender: UIButton)
    {
        searchTextInput.endEditing(true)
        searchTextInput.placeholder = "Search"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        searchTextInput.endEditing(true)
        searchTextInput.placeholder = "Search"
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        if textField.text != ""
        {
            return true
        }
        else
        {
            textField.placeholder = "Must Type Something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if let city = searchTextInput.text
        {
            weatherManager.GetWeatherData(cityName: city)
            //temperatureLabel.text = weatherMod
        }
        searchTextInput.text = ""
    }
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate
{
    func DidUpdateWeather(weatherManager: WeatherManager, weather: WeatherModel)
    {
        DispatchQueue.main.async
            {
                self.temperatureLabel.text = weather.temperatureString
                self.conditionImageView.image = UIImage(systemName: weather.conditionName)
                self.cityLabel.text = weather.cityName
            }
    }
    
    func DidFailWithError(error: Error)
    {
        print(error)
    }
}

//MARK: - LocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if let location = locations.last
        {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.FetchWeather(latitude: lat, longitude: lon)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print(error)
    }
}
