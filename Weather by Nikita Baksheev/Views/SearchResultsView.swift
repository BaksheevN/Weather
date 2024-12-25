//
//  SearchResultsView.swift
//  Weather by Nikita Baksheev
//
//  Created by Nikita Baksheev on 24.12.2024.
//

import SwiftUI

struct SearchResultsView: View {
    
    @ObservedObject var weatherViewModel: WeatherViewModel
    @Binding var text: String
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                ForEach(weatherViewModel.searchResults, id: \.0.id) { result in
                    RowView(city: result.0, current: result.1, image: result.2)
                        .onTapGesture {
                            Task {
                                await weatherViewModel.loadCurrentWeather(from: result.0.name)
                                await MainActor.run {
                                    withAnimation {
                                        weatherViewModel.isCancelledSearch = true
                                        weatherViewModel.searchResults.removeAll()
                                        text = ""
                                        hideKeyboard()
                                    }
                                }
                            }
                        }
                }
            }
        }
    }
}

struct RowView: View {
    
    var city: SearchLocation
    var current: Current
    var image: UIImage?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: buttonRadius)
                .foregroundStyle(backgroundColor)
            HStack {
                Spacer()
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                }
            }
            .frame(height: 85)
            .padding(edgeInsetsWithinRow)
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text(city.name)
                        .font(.poppins(size: 20, weight: "SemiBold"))
                        .foregroundStyle(textColor)
                        .offset(y: 10)
                    Text("\(current.tempInt)")
                        .font(.poppins(size: 60, weight: "Medium"))
                        .foregroundStyle(textColor)
                        .offset(y: 6)
                }
                Spacer()
            }
            .frame(height: 85)
            .padding(edgeInsetsWithinRow)
        }
        .frame(height: rowHeight)
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}


#Preview {
    SearchResultsView(weatherViewModel: WeatherViewModel(), text: .constant(""))
}

private let textColor = Color(red: 44/255, green: 44/255, blue: 44/255)
private let backgroundColor = Color(red: 242/255, green: 242/255, blue: 242/255)
private let buttonRadius: CGFloat = 16
private let rowHeight: CGFloat = 117
private let edgeInsetsWithinRow: EdgeInsets = EdgeInsets(top: 16, leading: 31, bottom: 16, trailing: 31)
