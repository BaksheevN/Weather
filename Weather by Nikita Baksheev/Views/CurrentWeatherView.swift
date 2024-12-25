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
            // weather details
            if weatherViewModel.citySelected {
                ZStack {
                    RoundedRectangle(cornerRadius: buttonRadius)
                        .foregroundStyle(backgroundColor)
                    HStack(alignment: .center) {
                        // humidity
                        if let humidity = weatherViewModel.humidity {
                            VStack {
                                Text("Humidity")
                                    .font(.poppins(size: 12, weight: "Medium"))
                                    .foregroundStyle(headerColor)
                                Text("\(humidity)")
                                    .font(.poppins(size: 15, weight: "Medium"))
                                    .foregroundStyle(textDetailColor)
                            }
                        }
                        Spacer()
                        // UV
                        if let UV = weatherViewModel.UV {
                            VStack {
                                Text("UV")
                                    .font(.poppins(size: 12, weight: "Medium"))
                                    .foregroundStyle(headerColor)
                                Text("\(UV)")
                                    .font(.poppins(size: 15, weight: "Medium"))
                                    .foregroundStyle(textDetailColor)
                            }
                        }
                        Spacer()
                        // feels like
                        if let feelsLike = weatherViewModel.feelsLike {
                            VStack {
                                Text("Feels Like")
                                    .font(.poppins(size: 12, weight: "Medium"))
                                    .foregroundStyle(headerColor)
                                Text("\(feelsLike)")
                                    .font(.poppins(size: 15, weight: "Medium"))
                                    .foregroundStyle(textDetailColor)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .frame(height: 75)
                .padding(.top, 20)
                .padding(.horizontal, 50)
            }
        }
    }
}

#Preview {
    CurrentWeatherView(weatherViewModel: WeatherViewModel())
}

private let textColor = Color(red: 44/255, green: 44/255, blue: 44/255)
private let backgroundColor = Color(red: 242/255, green: 242/255, blue: 242/255)
private let buttonRadius: CGFloat = 16
private let headerColor = Color(red: 196/255, green: 196/255, blue: 196/255)
private let textDetailColor = Color(red: 154/255, green: 154/255, blue: 154/255)
