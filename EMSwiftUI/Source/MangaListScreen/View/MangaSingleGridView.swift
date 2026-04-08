//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI

struct MangaSingleGridView: View {
    let item: MangaItemUIModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            coverImage
            
            Text(item.title)
                .font(Font.SFPro.headline2)
                .lineLimit(1)
            
            RatingView(rating: 4.3, maxRating: 5)
            
            Text(item.tag)
                .font(Font.SFPro.bodyNormal)
                .foregroundStyle(Color.grayBase)
        }
    }
    
    private var coverImage: some View {
        ZStack {
            Color.gray.opacity(0.3)
            
            if let url = item.converURL {
                AsyncImage(url: url) { image in
                    image.resizedToFill(width: 100, height: 144)
                } placeholder: {
                    ProgressView()
                }
            } else {
                Image(systemName: "photo")
                    .foregroundStyle(Color.gray)
            }
        }
        .frame(width: 100, height: 144)
        .cornerRadius(8)
        .clipped()
    }
}
