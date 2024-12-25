//
//  CommonExtensions.swift
//  Weather by Nikita Baksheev
//
//  Created by Nikita Baksheev on 25.12.2024.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
