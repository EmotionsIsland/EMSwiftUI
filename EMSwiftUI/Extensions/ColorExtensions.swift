//
//  ColorExtensions.swift
//  EMSwiftUI
//
//  Created by Kristina Grebneva on 05.03.2025.
//

import SwiftUI

// extension используется для иницииализации цвета
// по шестнадцатеричному коду (hex)
extension Color {
    static let customGray = Color(hex: "#C4C4C4")
    static let customBlack = Color(hex: "#383838")

    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
