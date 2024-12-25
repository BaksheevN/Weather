//
//  SearchLocationField.swift
//  Weather by Nikita Baksheev
//
//  Created by Nikita Baksheev on 20.12.2024.
//

import SwiftUI

/// TextField with a custom background which activates once it's tapped
struct SearchLocationField: View {
    
    private var prompt: String
    var weatherViewModel: WeatherViewModel
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    init(_ prompt: String = "", text: Binding<String>, weatherViewModel: WeatherViewModel) {
        self.prompt = prompt
        self._text = text
        self.weatherViewModel = weatherViewModel
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: buttonRadius)
                .foregroundStyle(backgroundColor)
            TextField("", text: $text, prompt: Text(prompt).foregroundStyle(promptColor))
                .focused($isFocused)
                .padding(.horizontal, 20)
                .font(.poppins(size: 16, weight: "Regular"))
                .onChange(of: text) {
                    if text != "" {
                        Task {
                            do {
                                try await weatherViewModel.fetchSearchingCititesWithWeather(from: text)
                            } catch {
                                print(error)
                            }
                        }
                    }
                }
            
            HStack {
                Spacer()
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundStyle(promptColor)
                    .padding(.horizontal, 20)
            }
        }
        .onTapGesture {
            isFocused = true // Activates the TextField when the custom area is tapped
        }
    }
}

private let backgroundColor = Color(red: 242/255, green: 242/255, blue: 242/255)
private let promptColor = Color(red: 196/255, green: 196/255, blue: 196/255)
private let buttonRadius: CGFloat = 16
