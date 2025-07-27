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
        VStack {
            HStack(spacing: 4) {
                ForEach(0..<maxRating, id: \.self) { index in
                    let starType = starImageType(for: index)
                    Image(systemName: starType)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 17, height: 16)
                        .foregroundColor(.yellow)
                }
            }
        }
    }
    
    private func starImageType(for index: Int) -> String {
            let fullStars = Int(rating)
            let hasHalfStar = rating - CGFloat(fullStars) >= 0.25 && rating - CGFloat(fullStars) < 0.75

            if index < fullStars {
                return "star.fill"
            } else if index == fullStars && hasHalfStar {
                return "star.leadinghalf.filled"
            } else {
                return "star"
            }
        }
}
