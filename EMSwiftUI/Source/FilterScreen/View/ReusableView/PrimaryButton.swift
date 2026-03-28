//
//  PrimaryButton.swift
//  EMSwiftUI
//
//  Created by Денис Ефименков on 11.02.2026.
//
import SwiftUI

struct PrimaryButton: View {
    let title: String
    let bgColor: Color
    let textColor: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
        }
        .background(bgColor)
        .foregroundColor(textColor)
        .cornerRadius(12)
    }
}
