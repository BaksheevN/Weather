//
//  WeatherStorage.swift
//  Weather by Nikita Baksheev
//
//  Created by Nikita Baksheev on 23.12.2024.
//

import Foundation

let WeatherStorageKey = "WeatherStorage"
let ImageWeatherStorageKey = "ImageWeatherStorage"

var currentWeatherUserDefaults: Data? {
    get {
        UserDefaults.standard.object(forKey: WeatherStorageKey) as? Data
    }
    set {
        UserDefaults.standard.set(newValue, forKey: WeatherStorageKey)
    }
}

var imageWeatherUserDefaults: Data? {
    get {
        UserDefaults.standard.object(forKey: ImageWeatherStorageKey) as? Data
    }
    set {
        UserDefaults.standard.set(newValue, forKey: ImageWeatherStorageKey)
    }
}


