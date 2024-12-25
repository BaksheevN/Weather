//
//  SearchLocationView.swift
//  Weather by Nikita Baksheev
//
//  Created by Nikita Baksheev on 20.12.2024.
//

import SwiftUI

/// TextField with a custom background which activates once it's tapped
struct SearchLocationField: View {
    
    private var prompt: String
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    init(_ prompt: String = "", text: Binding<String>) {
        self.prompt = prompt
        self._text = text
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: buttonRadius)
                .foregroundStyle(backgroundColor)
            Color.clear
                .contentShape(Rectangle()) // Ensures the shape is tappable
            TextField(prompt, text: $text)
                .focused($isFocused)
                .padding(.horizontal, 20)
        }
        .onTapGesture {
            isFocused = true // Activates the TextField when the custom area is tapped
        }

    }
}
