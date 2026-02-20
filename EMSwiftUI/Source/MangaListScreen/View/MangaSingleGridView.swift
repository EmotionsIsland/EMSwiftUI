//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI
import Netify

struct MangaSingleGridView: View {
    let imageURL: URL?
    let title: String
    let rating: CGFloat
    let tags: String
    
    var body: some View {
        VStack(spacing: 4) {
            AsyncImage(url: imageURL) { image in
                image.image?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .frame(height: 144)
            .clipped()
            .cornerRadius(4)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.SFPro.semiboldNormal)
                    .lineLimit(1)
                
                RatingView(rating: rating, maxRating: 5)
                
                Text(tags)
                    .font(.SFPro.lightSmall)
                    .foregroundColor(.grayBase)
                    .lineLimit(1)
                
                Spacer(minLength: 0)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
