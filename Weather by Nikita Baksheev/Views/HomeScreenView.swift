//
//  HomeScreenView.swift
//  Weather by Nikita Baksheev
//
//  Created by Nikita Baksheev on 21.12.2024.
//

import SwiftUI

struct HomeScreenView: View {

    @StateObject private var keyboardObserver: KeyboardObserver = KeyboardObserver()
    @ObservedObject private var weatherViewModel: WeatherViewModel = WeatherViewModel()
    @State var isSearching: Bool = false
    @State var text: String = ""
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                SearchLocationField("Search Location",
                                    text: $text,
                                    weatherViewModel: weatherViewModel)
                    .frame(height: searchHeight)
                    .padding(.horizontal, 24)
                    .padding(.top, 8)
                if weatherViewModel.searchResults.isEmpty {
                    CurrentWeatherView(weatherViewModel: weatherViewModel)
                        .padding(.top, keyboardObserver.isKeyboardVisible ? 0 : 74)
                }
                if !weatherViewModel.searchResults.isEmpty {
                    SearchResultsView(weatherViewModel: weatherViewModel, text: $text)
                }
                Spacer(minLength: 0)
            }
        }
        .alert(item: $weatherViewModel.errorMessage) { error in
            Alert(title: Text("Error"),
                  message: Text(error.message),
                  dismissButton: .default(Text("Ok"), action: {
                weatherViewModel.errorMessage = nil
            }))
        }
    }
}

#Preview {
    HomeScreenView()
}

private let searchHeight: CGFloat = 46

