//
//  View+Extensions.swift
//  EMSwiftUI
//
//  Created by Danila Umnov on 07.08.2026.
//

import SwiftUI

extension View {
    func bottomSeparator(color: Color = .grayBase, height: CGFloat = 1) -> some View {
        self
            .padding(.bottom, 8)
            .overlay(alignment: .bottom) {
                Rectangle()
                    .frame(height: height)
                    .foregroundColor(color)
            }
    }
}
