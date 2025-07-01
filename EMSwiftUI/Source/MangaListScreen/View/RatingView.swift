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
            let stars = HStack(spacing: 0) {
                ForEach(0..<maxRating) { _ in
                    Image(uiImage: .starIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }

            stars.overlay(
                GeometryReader { proxy in
                    let width = rating / CGFloat(maxRating) * proxy.size.width
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(width: width)
                            .foregroundColor(.yellow)
                    }
                }
                .mask(stars)
            )
            .foregroundColor(.grayBase)
    }
}
