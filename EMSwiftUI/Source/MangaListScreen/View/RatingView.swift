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
        let decimalPart = rating - CGFloat(fullStars)
        
        if index < fullStars {
            return "star.fill"
        } else if index == fullStars && decimalPart >= 0.1 && decimalPart < 0.9 {
            return "star.leadinghalf.filled"
        } else {
            return "star"
        }
    }
}

#Preview {
    VStack {
        RatingView(rating: 4.2, maxRating: 5)
        RatingView(rating: 2.7, maxRating: 5)
        RatingView(rating: 3.8, maxRating: 5)
    }
}
