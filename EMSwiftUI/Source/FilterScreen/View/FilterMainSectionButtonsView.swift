//
//  FilterMainSectionButtonsView.swift
//  EMSwiftUI
//
//  Created by Глеб Поляков on 07.07.2025.
//

import SwiftUI

struct FilterMainSectionButtonsView: View {
    let isActive: Bool
    var resetAction: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            Button { }
            label: {
                Text("Apply")
                    .foregroundStyle(.whiteText)
                    .padding(12)
                    .frame(maxWidth: .infinity)
                    .background(isActive ? .orangeBase : .grayBase)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .disabled(!isActive)
            Button {
                resetAction()
            } label: {
                Text("Reset")
                    .foregroundStyle(.blackBase)
            }
            .disabled(!isActive)
        }
        .font(.SFPro.bodyNormal)
    }
}
