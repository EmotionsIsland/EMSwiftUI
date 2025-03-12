//
//  TagView.swift
//  EMSwiftUI
//
//  Created by Павел Градов on 12.03.2025.
//

import SwiftUI

struct TagView<Content: View>: View {
    let title: String

    @State private var isExpanded: Bool = false
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 8) {
                Text(title)
                    .font(FontFamily.SFPro.regular.swiftUIFont(fixedSize: 20))
                Image(systemName: "chevron.down")
                    .rotationEffect(.degrees(isExpanded ? 180 : 0))
                    .animation(.easeInOut, value: isExpanded)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.easeInOut) {
                    isExpanded.toggle()
                }
            }
            
            if isExpanded {
                content()
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }
}

#Preview {
    TagView(title: "Default title") {
        Text("Simple text")
    }
}
