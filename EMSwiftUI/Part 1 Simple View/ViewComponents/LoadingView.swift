//
//  LoadingView.swift
//  EMSwiftUI
//
//  Created by Павел Градов on 07.03.2025.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(spacing: 10) {
            ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(1.5)
            Text("Loading...")
                .font(.subheadline)
                .foregroundStyle(.blackBase)
        }
    }
}

#Preview {
    LoadingView()
}
