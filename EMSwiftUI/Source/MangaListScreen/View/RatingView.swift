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
            stars
                .foregroundStyle(.grayBase.opacity(0.3))

            stars
                .foregroundStyle(.yellow)
                .mask(alignment: .leading) {
                    GeometryReader { proxy in
                        Rectangle()
                            .frame(width: proxy.size.width * rating / CGFloat(maxRating))
                    }
                }
        }
    }

    private var stars: some View {
        HStack(spacing: 2) {
            ForEach(0..<maxRating, id: \.self) { _ in
                Image(.starIcon)
                    .resizable()
                    .frame(width: 12, height: 12)
            }
        }
    }
}
