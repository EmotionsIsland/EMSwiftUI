//
//  Buttons.swift
//  EMSwiftUI
//
//  Created by Анатолий Чириков on 24.03.2026.
//

import SwiftUI

struct Buttons: View {
    let onReset: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            Button("Apply", action: {
                print("Tapped")
            })
            .buttonStyle(MainButtonStyle(backghroundColor: Color.orangeBase,
                                         foregroundStyle: Color.white))
            Button("Reset", action: onReset)
                .buttonStyle(MainButtonStyle(backghroundColor: .clear,
                                             foregroundStyle: Color.blackBase))
        }
        .padding(.top, 8)
    }
}
