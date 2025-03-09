//
//  ErrorView.swift
//  EMSwiftUI
//
//  Created by Павел Градов on 07.03.2025.
//

import SwiftUI

struct ErrorView: View {
    let errorMessage: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundColor(.orange)
            Text("Error:")
                .font(FontFamily.SFPro.black.swiftUIFont(size: 16))
                .foregroundStyle(.blackBase)
            Text(errorMessage)
                .padding(.horizontal)
                .font(FontFamily.SFPro.regular.swiftUIFont(size: 16))
                .multilineTextAlignment(.center)
                .foregroundColor(.blackBase)
        }
    }
}

#Preview {
    ErrorView(errorMessage: "Error description")
}
