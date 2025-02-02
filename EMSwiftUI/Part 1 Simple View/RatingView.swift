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
                    .frame(width: 15, height: 15)
                    .foregroundColor(.yellow)
            }
        }
    }
}
