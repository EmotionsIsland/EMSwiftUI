//
//  ShimmerView.swift
//  EMSwiftUI
//
//  Created by mm pechenbku on 05.06.2025.
//

import SwiftUI

struct ShimmerView<V: View>: View {
    let view: V

    var body: some View {
        view
            .redacted(reason: .placeholder)
            .modifier(Shimmer())
    }
}

public struct Shimmer: ViewModifier {
    @State var isInitialState: Bool = true

    public func body(content: Content) -> some View {
        content
            .mask(
                LinearGradient(
                    gradient: .init(colors: [.blackBase.opacity(0.4), .blackBase, .blackBase.opacity(0.4)]),
                    startPoint: (isInitialState ? .init(x: -0.3, y: -0.3) : .init(x: 1, y: 1)),
                    endPoint: (isInitialState ? .init(x: 0, y: 0) : .init(x: 1.3, y: 1.3))
                )
            )
            .animation(.linear(duration: 1.5).delay(0.25).repeatForever(autoreverses: false), value: isInitialState)
            .onAppear {
                isInitialState = false
            }
    }
}

#Preview {
    ShimmerView(view: MangaListScreenBuilder.build())
}
