//
//  RatingView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct RatingView: View {
    private let viewModel = RatingViewViewModel()
        
    var body: some View {
        let rating = viewModel.getRandomRating
        let maxRating = viewModel.maxRating

        HStack {
            HStack(spacing: 2) {
                ForEach(0..<maxRating, id: \.self) { index in
                    StarView(
                        fillRatio: viewModel.fillRatio(for: index, rating: rating),
                        size: CGSize(width: 17, height: 16)
                    )
                }
            }
        }
    }
}

struct StarView: View {
    let fillRatio: CGFloat
    let size: CGSize
    
    var body: some View {
        ZStack(alignment: .leading) {
            Image("starIcon")
                .renderingMode(.template)
                .resizable()
                .frame(width: size.width, height: size.height)
                .foregroundColor(Color(white: 0.9))
            
            Image("starIcon")
                .renderingMode(.template)
                .resizable()
                .frame(width: size.width, height: size.height)
                .foregroundColor(.yellow)
                .mask(alignment: .leading) {
                    Rectangle()
                        .frame(width: size.width * fillRatio)
                }
        }
        .frame(width: size.width, height: size.height)
    }
}

#Preview {
    RatingView()
}
