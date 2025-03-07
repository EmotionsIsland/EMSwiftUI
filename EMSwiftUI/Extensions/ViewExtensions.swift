//
//  ViewExtensions.swift
//  EMSwiftUI
//
//  Created by Kristina Grebneva on 07.03.2025.
//

import SwiftUI

extension View {
    func orangeButtonStyle(color: Color) -> some View {
        self.modifier(OrangeButtonStyle(color: color))
    }
}

