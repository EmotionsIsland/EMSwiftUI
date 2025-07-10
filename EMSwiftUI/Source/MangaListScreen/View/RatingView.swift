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
    
    private let starImage = Image("starIcon")
    
    var body: some View {
        let stars = HStack(spacing: 0) {
            ForEach(0..<maxRating, id: \.self) { _ in
                starImage
                    .foregroundStyle(.grayBase)
            }
        }
        
        stars.overlay {
            GeometryReader { geometry in
                let width = rating / CGFloat(maxRating) * geometry.size.width
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: width)
                        .foregroundStyle(.yellow)
                }
            }
            .mask(stars)
        }
    }
}
