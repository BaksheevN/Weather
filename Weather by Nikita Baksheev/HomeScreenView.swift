//
//  HomeScreen.swift
//  Weather by Nikita Baksheev
//
//  Created by Nikita Baksheev on 21.12.2024.
//

import SwiftUI

struct HomeScreenView: View {
    @State var text: String = ""
    var body: some View {
        VStack {
            TextFieldWithTouchableBackground("Search location",
                                             text: $text,
                                             background: { RoundedRectangle(cornerRadius: buttonRadius)
                    .foregroundStyle(backgroundColor)
            })
            .frame(height: searchHeight)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    HomeScreenView()
}


let backgroundColor = Color(red: 242/255, green: 242/255, blue: 242/255)
let searchHeight: CGFloat = 46
let buttonRadius: CGFloat = 16
