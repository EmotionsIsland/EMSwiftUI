//
//  View+Extensions.swift
//  EMSwiftUI
//
//  Created by Alina Kazantseva on 7/14/25.
//

import SwiftUI

extension View {
    func placeholder<Content: View>(when shouldShow: Bool,
                                    alignment: Alignment = .leading,
                                    @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            if shouldShow {
                placeholder()
            }
            self
        }
    }
}
