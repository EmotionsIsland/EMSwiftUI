//
//  View.ext.swift
//  EMSwiftUI
//
//  Created by Павел Градов on 11.03.2025.
//

import SwiftUI

extension View {
    func readViewSize(onChange: @escaping (CGSize) -> ()) -> some View {
        background(GeometryReader { proxy in
            Color.clear
                .preference(key: SizePreferenceKey.self, value: proxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}
                   
private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) { }
}
