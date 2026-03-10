//
//  RatingView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct RatingView: View {
    let rating: Double
    let maxRating: Int = 5

    private let starSize: CGFloat = 12
    private let spacing: CGFloat = 2

    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<maxRating, id: \.self) { index in
                star(for: index)
            }
        }
    }

    @ViewBuilder
    private func star(for index: Int) -> some View {
        let starFill = min(max(rating - Double(index), 0), 1)

        ZStack(alignment: .leading) {
            Image("starIcon")
                .renderingMode(.original)
                .resizable()
                .frame(width: starSize, height: starSize)
                .opacity(0.3)

            if starFill > 0 {
                Image("starIcon")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: starSize, height: starSize)
                    .mask(
                        HStack(spacing: 0) {
                            Rectangle()
                                .frame(width: starSize * CGFloat(starFill))
                            Spacer(minLength: 0)
                        }
                    )
            }
        }
    }
}
