//
//  RatingView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaRatingView: View {
    let rating: CGFloat
    let maxRating: Int
    
    var body: some View {
        let starsView = HStack(spacing: 4) {
            ForEach(0..<maxRating, id: \.self) { _ in
                Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        
        starsView
        .foregroundStyle(.gray)
        .overlay {
            GeometryReader { proxy in
                let width = rating / CGFloat(maxRating) * proxy.size.width
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: width)
                        .foregroundColor(.yellow)
                }
            }
            .mask(starsView)
        }
    }
}

#Preview {
    MangaRatingView(rating: 4.3, maxRating: 5)
}
