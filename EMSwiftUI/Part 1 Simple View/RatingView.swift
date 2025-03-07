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
                Image(.starIcon)
                    .resizable()
                    .foregroundStyle(index < Int(rating) ? .yellow : .whiteText)
                    .frame(width: 17, height: 16)
                    
            }
        }
    }
}

#Preview {
    RatingView(rating: 4, maxRating: 5)
}
