//
//  WeartherAPI.swift
//  Weather by Nikita Baksheev
//
//  Created by Nikita Baksheev on 20.12.2024.
//

import Foundation

class WheatherViewModel: ObservableObject {
    
    let key = "82bd8d5034084af3baf223532242012"
    let currentWheatherURL = "http://api.weatherapi.com/v1/current.json?key=keydata&q=city&aqi=no"
    private var currentCity: String = ""
    
    
    func getCurrentWheather(for city: String) {
        let URL = currentWheatherURL.replacingOccurrences(of: "city", with: city)
    }
    
}
