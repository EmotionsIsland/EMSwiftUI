//
//  Button+Styles.swift
//  EMSwiftUI
//
//  Created by Danila Umnov on 07.08.2026.
//

import SwiftUI

struct OrangeButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.SFPro.mediumNormal)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(.orangeBase)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}

struct ResetButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.SFPro.mediumNormal)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .foregroundStyle(.blackBase)
            .opacity(configuration.isPressed ? 0.6 : 1.0)
    }
}

extension ButtonStyle where Self == OrangeButtonStyle {
    static var orange: OrangeButtonStyle { OrangeButtonStyle() }
}

extension ButtonStyle where Self == ResetButtonStyle {
    static var reset: ResetButtonStyle { ResetButtonStyle() }
}

extension View {
    func orangeButtonStyle() -> some View {
        self.buttonStyle(.orange)
    }

    func resetButtonStyle() -> some View {
        self.buttonStyle(.reset)
    }
}
