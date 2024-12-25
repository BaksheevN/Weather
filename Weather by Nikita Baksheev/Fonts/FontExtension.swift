//
//  FontExtension.swift
//  Weather by Nikita Baksheev
//
//  Created by Nikita Baksheev on 21.12.2024.
//

import SwiftUI

extension Font {
    static func poppins(size: CGFloat, weight: String = "Regular") -> Font {
        return .custom("Poppins-\(weight)", size: size)
    }
}
