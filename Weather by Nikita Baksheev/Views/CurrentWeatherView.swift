//
//  CurrentWeatherView.swift
//  Weather by Nikita Baksheev
//
//  Created by Nikita Baksheev on 24.12.2024.
//

import SwiftUI

struct CurrentWeatherView: View {

    @ObservedObject var weatherViewModel: WeatherViewModel

    var body: some View {
        VStack(spacing: 0) {
            // weather condition icon
            if let image = weatherViewModel.currentImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 123)
            }
            // chosen city
            HStack {
                Text(weatherViewModel.chosenCity)
                    .font(.poppins(size: 30, weight: "SemiBold"))
                    .foregroundStyle(textColor)
                if weatherViewModel.citySelected {
                    Image(systemName: "location.fill")
                        .font(.poppins(size: 21, weight: "SemiBold"))
                        .foregroundStyle(textColor)
                }
            }
            // temperature
            if let temp = weatherViewModel.temp {
                HStack(alignment: .top) {
                    Text("\(temp)")
                        .font(.poppins(size: 70, weight: "Medium"))
                        .foregroundStyle(textColor)
                    Text(" °")
                        .font(.poppins(size: 25, weight: "Medium"))
                        .foregroundStyle(textColor)
                        .padding(.top, 6)
                }
            }
        }
    }
}

#Preview {
    CurrentWeatherView(weatherViewModel: WeatherViewModel())
}

private let textColor = Color(red: 44/255, green: 44/255, blue: 44/255)
