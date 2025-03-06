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
        VStack {
            ForEach(0..<maxRating, id: \.self) { index in
                Image(.starIcon)
                    .foregroundStyle(.yellow)
            }
        }
    }
}

#Preview {
    RatingView(rating: 4, maxRating: 5)
}
