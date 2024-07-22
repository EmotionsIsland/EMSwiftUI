//
//  View + Extensions.swift
//  EMSwiftUI
//
//  Created by Vladislav Miroshnichenko on 14.07.2024.
//

import SwiftUI

extension View {
    
    public func getSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometry in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometry.size)
                
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
    
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) { }
}
