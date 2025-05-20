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
        HStack(spacing: 4) {
            ForEach(0..<maxRating, id: \.self) { index in
                ZStack(alignment: .leading) {
                    Image(.starIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                        .foregroundColor(.gray)
                    GeometryReader { geometry in
                        Image(.starIcon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                            .foregroundColor(.yellow)
                            .clipShape(
                                Rectangle()
                                    .path(in: CGRect(
                                        x: 0,
                                        y: 0,
                                        width: min(CGFloat(1), max(rating - CGFloat(index), 0)) * geometry.size.width,
                                        height: geometry.size.height)
                                    )
                            )
                    }
                    .frame(width: 16, height: 16)
                }
            }
        }
    }
}
