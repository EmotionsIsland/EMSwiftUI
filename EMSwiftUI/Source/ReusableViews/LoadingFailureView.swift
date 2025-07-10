//
//  LoadingFailureView.swift
//  EMSwiftUI
//
//  Created by Глеб Поляков on 10.07.2025.
//

import SwiftUI

struct LoadingFailureView: View {
    let errorMessage: String
    let buttonTapHandler: () async -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            Text(errorMessage)
                .font(.SFPro.semiboldNormal)
                .multilineTextAlignment(.center)
                .padding()
            Button("Try again") {
                Task {
                    await buttonTapHandler()
                }
            }
            .foregroundStyle(.whiteText)
            .padding(12)
            .frame(maxWidth: .infinity)
            .background(.orangeBase)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.horizontal)
        }
    }
}
