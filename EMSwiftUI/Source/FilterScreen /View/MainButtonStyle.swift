//
//  ButtonsStyle.swift
//  EMSwiftUI
//
//  Created by Анатолий Чириков on 07.04.2026.
//

import SwiftUI

struct MainButtonStyle: ButtonStyle {
    let backghroundColor: Color
    let foregroundStyle: Color
    let cornerRadius: CGFloat = 8
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundStyle(foregroundStyle)
            .background(backghroundColor)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}
