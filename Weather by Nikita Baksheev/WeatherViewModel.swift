//
//  WeatherViewModel.swift
//  Weather by Nikita Baksheev
//
//  Created by Nikita Baksheev on 20.12.2024.
//

import SwiftUI
import Combine

class WeatherViewModel: ObservableObject {
    
    let key = "82bd8d5034084af3baf223532242012"
    let currentWeatherURL = "https://api.weatherapi.com/v1/current.json?key=keydata&q=city&aqi=no"
    let searchURL = "https://api.weatherapi.com/v1/search.json?key=keydata&q=text"
    @Published var searchResults: [(SearchLocation, Current, UIImage?)]
    @Published private var currentWeather: WeatherModel?
    @Published var currentImage: UIImage?
    @Published var errorMessage: String?
    private var autoUpdateCancelleble: AnyCancellable?
    private var autoImageUpdateCancelleble: AnyCancellable?
        
    init() {
        self.searchResults = []
        // load saved weather from userDefaults
        if let currentWeatherUserDefaults = currentWeatherUserDefaults {
            if let currentWeather = try? JSONDecoder().decode(WeatherModel.self, from: currentWeatherUserDefaults) {
                self.currentWeather = currentWeather
            }
        }
        if let imageWeatherUserDefaults = imageWeatherUserDefaults {
            self.currentImage = UIImage(data: imageWeatherUserDefaults)
        }
        // auto save current weather and image
        autoUpdateCancelleble = $currentWeather.sink { currentWeather in
            if let currentWeather {
                currentWeatherUserDefaults = currentWeather.json
            }
        }
        autoImageUpdateCancelleble = $currentImage.sink { currentConditionImage in
            if let currentConditionImage {
                imageWeatherUserDefaults = currentConditionImage.pngData()
            }
        }
    }
    
    var citySelected: Bool {
        currentWeather != nil
    }
    
    var chosenCity: String {
        currentWeather?.location.name ?? "No City Selected"
    }
    
    var temp: Int? {
        guard let temp = currentWeather?.current.temp_f else { return nil }
        return Int(temp)
    }
    
    func fetchSearchingCititesWithWeather(from text: String) async throws {
        do {
            let cities = try await fetchSearchingCities(from: text)
            var searchedResults: [(SearchLocation, Current, UIImage)] = []
            for city in cities {
                let currentWeather = try await fetchCurrentWeather(from: city.name)
                let image = try await fetchImage(from: currentWeather.current.imageURLString)
                searchedResults.append((city, currentWeather.current, image))
            }
            let results = searchedResults
            await MainActor.run {
                withAnimation{
                    searchResults = results
                }
            }
        } catch {
            await MainActor.run {
                errorHandler(error: error)
            }
        }
    }
    
    private func fetchSearchingCities(from text: String) async throws -> [SearchLocation] {
                
        let urlString = searchURL
            .replacingOccurrences(of: "text", with: text)
            .replacingOccurrences(of: "keydata", with: key)
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
                     
        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            print(response)
            throw NetworkError.invalidResponse
        }
        
        guard let decodedCities = try? JSONDecoder().decode([SearchLocation].self, from: data) else {
            throw NetworkError.invalidData
        }
        
        return decodedCities
        
    }
    
    func loadCurrentWeather(from urlString: String) async -> Void {
        do {
            let currentWeather = try await fetchCurrentWeather(from: urlString)
            await MainActor.run {
                withAnimation(.easeIn(duration: animationDuration)) {
                    self.currentWeather = currentWeather
                }
            }
            await loadImage(from: currentWeather.current.imageURLString)
        } catch {
            await MainActor.run {
                errorHandler(error: error)
            }
        }
    }
    
    private func fetchCurrentWeather(from city: String) async throws -> WeatherModel {
                
        let urlString = currentWeatherURL
            .replacingOccurrences(of: "city", with: city)
            .replacingOccurrences(of: "keydata", with: key)
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
                     
        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            print(response)
            throw NetworkError.invalidResponse
        }
        
        guard let decodedWeather = try? JSONDecoder().decode(WeatherModel.self, from: data) else {
            throw NetworkError.invalidData
        }
        
        return decodedWeather
        
    }
    
    private func loadImage(from urlString: String) async -> Void {
        do {
            let image = try await fetchImage(from: urlString)
            await MainActor.run {
                withAnimation(.easeIn(duration: animationDuration)) {
                    self.currentImage = image
                }
            }
        } catch {
            await MainActor.run {
                errorHandler(error: error)
            }
        }
    }
    
    private func fetchImage(from urlString: String) async throws -> UIImage {
                
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        guard let image = UIImage(data: data) else {
            throw NetworkError.invalidData
        }
        
        return image
        
    }
    
    func errorHandler(error: Error) {
        withAnimation(.easeIn(duration: animationDuration)) {
            self.currentImage = nil
            self.currentWeather = nil
            self.searchResults = []
            if let networkError = error as? NetworkError {
                errorMessage = networkError.localizedDescription
            } else if let urlError = error as? URLError {
                errorMessage = "Network error: \(urlError.localizedDescription)"
            } else {
                errorMessage = "Unexpected error: \(error.localizedDescription)"
            }
            print(errorMessage ?? "")
        }
    }

}

// Custom Error Enum
enum NetworkError: LocalizedError {
    
    case invalidURL
    case invalidImageURL
    case invalidResponse
    case invalidImageResponse
    case invalidData
    case invalidImageData

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .invalidImageURL:
            return "The image URL is invalid."
        case .invalidResponse:
            return "The server responded with an invalid status code."
        case .invalidImageResponse:
            return "The image server responded with an invalid status code."
        case .invalidData:
            return "The received data is invalid or could not be processed."
        case .invalidImageData:
            return "The received imagedata is invalid or could not be processed."
        }
    }
}

let animationDuration: Double = 0.35

