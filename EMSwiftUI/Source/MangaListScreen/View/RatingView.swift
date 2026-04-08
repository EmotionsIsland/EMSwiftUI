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
        ZStack(alignment: .leading) {
            HStack(spacing: 2) {
                ForEach(0..<maxRating, id: \.self) { _ in
                Image("starIcon")
                        .foregroundStyle(Color(.gray).opacity(0.3))
                        .font(.caption)
                }
            }
            .overlay(
            GeometryReader { geometry in
                HStack(spacing: 2) {
                    ForEach(0..<maxRating, id: \.self) { _ in
                    Image("starIcon")
                            .foregroundStyle(Color.yellowRating)
                            .font(.caption)
                    }
                }
                .mask {
                    Rectangle()
                        .frame(width: geometry.size.width * rating / Double(maxRating))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            , alignment: .leading)
        }
    }
}
