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
        HStack(spacing: 4) {
            ForEach(0..<maxRating, id: \.self) { index in
                ZStack {
                    starImage
                        .foregroundStyle(.grayBase)
                    
                    if rating >= Double(index + 1) {
                        starImage
                            .foregroundStyle(.yellow)
                    } else if rating > Double(index) {
                        starImage
                            .foregroundStyle(.yellow)
                            .mask {
                                GeometryReader { geo in
                                    Rectangle()
                                        .size(
                                            width: geo.size.width * (rating - Double(index)),
                                            height: geo.size.height)
                                }
                            }
                    }
                }
            }
        }
    }
}
