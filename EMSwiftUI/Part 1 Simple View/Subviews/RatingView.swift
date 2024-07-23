//
//  RatingView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct RatingView: View {
    
    private let rating: CGFloat
    private let maxRating: Int
    
    var body: some View {
        VStack {
            stars.overlay {
                GeometryReader { item in
                    let width = rating / CGFloat(maxRating) * item.size.width
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(width: width)
                            .foregroundStyle(Color.yellow)
                    }
                }.mask(stars)
            }
            .foregroundStyle(Color.gray)
        }
    }
    
    private var stars: some View {
        HStack{
            ForEach(0..<maxRating, id: \.self) { _ in
                Image(.starIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
    
    public init(rating: CGFloat, maxRating: Int) {
        self.rating = rating
        self.maxRating = maxRating
    }
    
}

#Preview {
    RatingView(rating: 4, maxRating: 5)
}
