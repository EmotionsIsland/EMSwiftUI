//
//  RatingView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct RatingView: View {
    let rating: CGFloat
    let maxRating: Int = 5
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<maxRating, id: \.self) { index in
                ZStack {
                    Image(.starIcon)
                        .resizable()
                        .foregroundStyle(.whiteText)
                    Image(.starIcon)
                        .resizable()
                        .foregroundStyle(.yellow)
                        .mask {
                            GeometryReader { proxy in
                                Rectangle().frame(width: proxy.size.width * min(max(rating - Double(index), 0), 1))
                            }
                        }
                }
            }
        }
        .aspectRatio(contentMode: .fit)
    }
}
