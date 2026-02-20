//
//  RatingView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct RatingView: View {
    let rating: CGFloat
    let maxRating: Int
    
    var body: some View {
        ZStack(alignment: .leading) {
            starsRowView(with: maxRating, isTemplate: false)
                .overlay(
                    starsRowView(with: maxRating, isTemplate: true)
                        .foregroundColor(.grayBase)
                        .mask(
                            GeometryReader { geometry in
                                let ratingFraction = max(0, min(1, rating / CGFloat(maxRating)))
                                let grayWidth = geometry.size.width * (1 - ratingFraction)
                                
                                HStack(spacing: 0) {
                                    Spacer(minLength: 0)
                                    Rectangle()
                                        .frame(width: grayWidth)
                                }
                            }
                        )
                )
        }
    }
}

// MARK: - Private UI methods
extension RatingView {
    private func starsRowView(with maxRating: Int, isTemplate: Bool) -> some View {
        HStack(spacing: 4) {
            ForEach(0..<maxRating, id: \.self) { _ in
                Image(.starIcon)
                    .renderingMode(isTemplate ? .template : .original)
                    .resizedToFill(width: 17, height: 16)
            }
        }
    }
}
