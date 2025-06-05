//
//  RatingView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct RatingView: View {
    let rating: CGFloat
    let maxRating: Int = 5

    var body: some View {
        let stars = makeStars()

        stars.overlay(
            GeometryReader { geometry in
                let width = rating / CGFloat(maxRating) * geometry.size.width
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: width)
                        .foregroundColor(.yellow)
                }
            }
                .mask(stars)
        )
        .foregroundStyle(Color(.whiteText))
    }
}

private extension RatingView {
    func makeStars() -> some View {
        HStack(spacing: 0) {
            ForEach(0..<maxRating, id: \.self) { _ in
                Image(ImageResource.starIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}
