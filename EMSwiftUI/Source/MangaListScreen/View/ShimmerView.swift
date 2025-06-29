//
//  ShimmerView.swift
//  EMSwiftUI
//
//  Created by Katerina Ivanova on 27.06.2025.
//
import SwiftUI

struct ShimmerView: View {
    @State private var startPoint: UnitPoint = .init(x: -1.8, y: -1.2)
    @State private var endPoint: UnitPoint = .init(x: 0, y: -0.2)
    
    private var gradientColors = [
        Color.gray.opacity(0.2),
        Color.gray.opacity(0.5),
        Color.gray.opacity(0.2)
    ]
    
    var body: some View {
        LinearGradient(colors: gradientColors,
                       startPoint: startPoint,
                       endPoint: endPoint)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: false)) {
                startPoint = .init(x: 1, y: 1)
                endPoint = .init(x: 2.2, y: 2.2)
            }
        }
    }
}
