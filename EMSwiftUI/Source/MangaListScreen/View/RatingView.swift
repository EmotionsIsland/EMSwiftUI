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
        HStack(spacing: 2) {
            ForEach(0..<maxRating, id: \.self) { index in
                PartialStarView(fillPercent: starFillPercent(for: index))
            }
        }
        .frame(height: 16)
    }

    private func starFillPercent(for index: Int) -> CGFloat {
        let starValue = rating - CGFloat(index)
        return min(max(starValue, 0), 1)
    }
}

private struct PartialStarView: View {
    let fillPercent: CGFloat

    var body: some View {
        Image(.starIcon)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundStyle(.grayBase.opacity(0.3))
            .overlay(alignment: .leading) {
                Image(.starIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.yellow)
                    .mask(alignment: .leading) {
                        Rectangle()
                            .frame(width: 16 * fillPercent)
                    }
            }
            .frame(width: 16, height: 16)
    }
}
