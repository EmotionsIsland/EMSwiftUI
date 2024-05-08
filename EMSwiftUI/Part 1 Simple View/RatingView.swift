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
        let stars = HStack() {
            ForEach(1...maxRating, id: \.self) { _ in
                Image(.starIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
            .foregroundStyle(.grayBase)
        stars.overlay {
            GeometryReader { geometry in
                ZStack {
                    Rectangle()
                        .frame(width: (rating / CGFloat(maxRating)) * geometry.size.width)
                        .foregroundStyle(.yellow)
                    
                }
            }
            .mask(stars)
        }
    }
}

#Preview {
    RatingView(rating: 4, maxRating: 5)
}
