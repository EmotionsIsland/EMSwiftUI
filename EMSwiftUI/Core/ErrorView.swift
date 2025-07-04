//
//  ErrorView.swift
//  EMSwiftUI
//
//  Created by Katerina Ivanova on 30.06.2025.
//

import SwiftUI

struct ErrorView: View {
    let error: String
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Something went wrong:")
                .font(.headline)
            Text(error)
                .font(.subheadline)
                .foregroundStyle(.whiteText)
            Button("Please try again!") {
                action()
            }
            .foregroundStyle(.blackBase)
            .padding()
            .background(Color.orangeBase)
            .cornerRadius(12)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
