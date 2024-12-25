//
//  WeatherModel.swift
//  Weather by Nikita Baksheev
//
//  Created by Nikita Baksheev on 22.12.2024.
//

import Foundation

struct WeatherModel: Codable {

    let location: Location
    let current: Current

    var json: Data? {
        try? JSONEncoder().encode(self)
    }

}

struct Location: Codable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let tz_id: String
    let localtime_epoch: Int
    let localtime: String
}

struct Current: Codable {
    let temp_f: Double
    var tempInt: Int { Int(temp_f) }
    let condition: Condition
    let humidity: Int
    let feelslike_f: Double
    let uv: Double
    var imageURLString: String {
        "https:" + condition.icon
    }
}

struct Condition: Codable {
    let text: String
    let icon: String
    let code: Int
}

struct SearchLocation: Codable, Identifiable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let url: String
}
