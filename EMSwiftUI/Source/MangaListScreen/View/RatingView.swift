//
//  RatingView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct RatingView: View {
    let rating: Double
    let maxRating = Constants.maxRating
    let size = Constants.ratingSize
    let spacing = Constants.ratingSpacing
    var filledColor: Color = .yellow
    
    var body: some View {
        VStack {
            HStack(spacing: spacing) {
                ForEach(0..<maxRating, id: \.self) { index in
                    ZStack {
                        Image(systemName: "star.fill")
                            .resizedToFill(width: size, height: size)
                            .foregroundStyle(Color.gray.opacity(0.3))
                        if rating > CGFloat(index) {
                            Image(systemName: "star.fill")
                                .resizable()
                                .renderingMode(.original)
                                .foregroundStyle(Color.yellow)
                                .frame(width: 17, height: 17)
                                .mask(
                                    GeometryReader { geometry in
                                        let fillPercentage = min(rating - CGFloat(index), 1.0)
                                        Rectangle()
                                            .frame(width: geometry.size.width * fillPercentage,
                                                   height: geometry.size.height)
                                            .position(x: (geometry.size.width * fillPercentage) / 2,
                                                      y: geometry.size.height / 2)
                                    }
                                )
                        }
                    }
                }
            }
        }
    }
}
#Preview {
    RatingView(rating: 3.4)
}
