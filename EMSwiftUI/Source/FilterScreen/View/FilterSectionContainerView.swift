//
//  FilterSectionContainerView.swift
//  EMSwiftUI
//
//  Created by Дарина Самохина on 19.02.2026.
//

import SwiftUI

struct FilterSectionContainerView<Content: View>: View {
    let title: String
    let content: Content

    @State private var isExpanded = false

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Button(action: { withAnimation { isExpanded.toggle() }}, label: {
                HStack {
                    Text(title)
                        .font(.SFPro.regularLarge)
                        .foregroundColor(.blackBase)
                    Image(.expandDown)
                        .resizedToFill(width: 24, height: 24)
                        .rotationEffect(isExpanded ? .degrees(-180) : .degrees(0))
                    Spacer()
                }
                .padding(.horizontal, 16)
                .foregroundColor(.blackBase)
            })

            if isExpanded {
                content
                    .padding(.horizontal, 16)
            }
        }
    }
}
