//
//  RatingView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct RatingView: View {
    let rating: Double
    private let filledColor: Color = .yellow
    
    var body: some View {
        HStack(spacing: Constants.ratingSpacing) {
            ForEach(0..<Constants.maxRating, id: \.self) { index in
                ZStack {
                    Image(.starIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: Constants.ratingWidth, height: Constants.ratingHeight)
                        .foregroundStyle(Color.gray.opacity(0.3))
                    
                    if rating > Double(index) {
                        Image(.starIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: Constants.ratingWidth, height: Constants.ratingHeight)
                            .foregroundStyle(filledColor)
                            .mask(
                                Rectangle()
                                    .frame(width: CGFloat(min(rating - Double(index), 1.0)) * Constants.ratingWidth, height: Constants.ratingHeight)
                                    .position(x: (CGFloat(min(rating - Double(index), 1.0)) * Constants.ratingWidth) / 2,
                                              y: Constants.ratingHeight / 2)
                            )
                    }
                }
            }
        }
    }
}
