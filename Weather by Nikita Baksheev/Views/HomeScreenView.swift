//
//  HomeScreenView.swift
//  Weather by Nikita Baksheev
//
//  Created by Nikita Baksheev on 21.12.2024.
//

import SwiftUI

struct HomeScreenView: View {

    @ObservedObject private var weatherViewModel: WeatherViewModel = WeatherViewModel()
    @State var text: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            SearchLocationField("Search Location",
                                text: $text,
                                weatherViewModel: weatherViewModel)
                .frame(height: searchHeight)
            Color.clear.frame(height: 80)
            if let image = weatherViewModel.currentConditionImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 123)
            }
            HStack {
                Text(weatherViewModel.city)
                    .font(.poppins(size: 30, weight: "SemiBold"))
                    .foregroundStyle(textColor)
                if weatherViewModel.citySelected {
                    Image(systemName: "location.fill")
                        .font(.poppins(size: 21, weight: "SemiBold"))
                        .foregroundStyle(textColor)
                }
            }

            if let temp = weatherViewModel.temp {
                Text("\(temp)")
                    .font(.poppins(size: 70, weight: "Medium"))
                    .foregroundStyle(textColor)
            }
            Spacer()
        }
        .padding()
        
    }
}

#Preview {
    HomeScreenView()
}

private let searchHeight: CGFloat = 46
private let textColor = Color(red: 44/255, green: 44/255, blue: 44/255)

