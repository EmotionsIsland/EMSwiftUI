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
                Image(systemName: index < Int(rating) ? "star.fill" : "star")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 17, height: 16)
                    .foregroundColor(index < Int(rating) ? .yellow : .gray)
            }
        }
        .frame(maxWidth: 100)
    }
}

#Preview {
    RatingView(rating: 4, maxRating: 5)
}
