//
//  EmptyView.swift
//  EMSwiftUI
//
//  Created by Павел Градов on 07.03.2025.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "books.vertical")
                .font(.system(size: 48))
                .foregroundColor(.blackBase)
            Text("No data available")
                .font(FontFamily.SFPro.bold.swiftUIFont(size: 18))
                .foregroundColor(.blackBase)
            Text("Try to update later")
                .font(FontFamily.SFPro.regular.swiftUIFont(size: 16))
                .foregroundColor(.blackBase)
        }
    }
}

#Preview {
    EmptyView()
}
