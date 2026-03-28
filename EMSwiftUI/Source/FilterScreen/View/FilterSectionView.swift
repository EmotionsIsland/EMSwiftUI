//
//  FilterSectionView.swift
//  EMSwiftUI
//
//  Created by Денис Ефименков on 11.02.2026.
//

import SwiftUI

struct FilterSectionView<Content: View>: View {
    let title: String
    let isExpanded: Bool
    let onToggle: () -> Void
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Button(action: onToggle) {
                HStack {
                    Text(title)
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(.black)

                    Spacer()

                    Image("expandDown")
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                        .animation(.easeInOut(duration: 0.2), value: isExpanded)
                        .foregroundColor(.black.opacity(0.6))
                }
            }
            .buttonStyle(.plain)

            if isExpanded {
                content()
            }
        }
        .padding(.vertical, 10)
    }
}
