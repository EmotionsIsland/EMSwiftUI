//
//  RatingView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct RatingView: View {
    let maxRating: Int
    let rating: Double

    init(_ rating: Double, maxRating: Int = 5) {
        self.maxRating = maxRating
        self.rating = min(rating, Double(maxRating))
    }

    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<maxRating, id: \.self) { index in
                startView(for: index)
                    .frame(width: 17, height: 16)
            }
        }
    }

    @ViewBuilder
    func startView(for index: Int) -> some View {
        ZStack {
            Image(.starIcon)
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.grayBase)

            Image(.starIcon)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .mask(
                    GeometryReader { proxy in
                        let fillPercentage = min(max(rating - Double(index), 0), 1)

                        HStack(spacing: 0) {
                            Rectangle()
                                .frame(width: proxy.size.width * CGFloat(fillPercentage))

                            Rectangle()
                                .frame(width: proxy.size.width * CGFloat(1 - fillPercentage))
                                .opacity(0)
                        }
                    }
                )
        }
    }
}

#Preview {
    RatingView(Double.random(in: 1...5))
}
