//
//  HomeScreenView.swift
//  Weather by Nikita Baksheev
//
//  Created by Nikita Baksheev on 21.12.2024.
//

import SwiftUI

struct HomeScreenView: View {

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
                if !weatherViewModel.searchResults.isEmpty {
                    SearchResultsView(weatherViewModel: weatherViewModel, text: $text)
                }
                Spacer(minLength: 0)
            }
            if weatherViewModel.searchResults.isEmpty {
                CurrentWeatherView(weatherViewModel: weatherViewModel)
            }
        }
    }
}

#Preview {
    HomeScreenView()
}

private let searchHeight: CGFloat = 46

