//
//  View+Extension.swift
//  EMSwiftUI
//
//  Created by Katerina Ivanova on 29.06.2025.
//

import SwiftUI

extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

extension View {
    func primaryButtonStyle() -> some View {
        self
            .font(Font.SFPro.bodyNormal)
            .foregroundStyle(.whiteText)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(.orangeBase)
            .cornerRadius(8)
    }
    
    func secondaryButtonStyle() -> some View {
        self
            .font(Font.SFPro.bodyNormal)
            .foregroundStyle(.blackBase)
    }
}
