//
//  MangaSingleGridView.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 18/12/23.
//

import SwiftUI


struct MangaSingleGridView: View {
        
    let manga: MangaData
    let coverURL: URL
    
    var body: some View {
        VStack {
            AsyncImage(url: coverURL) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                Rectangle().fill(Color.gray.opacity(0.3))
            }
            .frame(width: 100, height: 144)
            .cornerRadius(8)
            
            Text(manga.attributes.title.en ?? "No eng title")
                .font(.custom(FontFamily.SFProText.bold, size: 16))
                .lineLimit(1)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            RatingView(rating: CGFloat.random(in: 0...5), maxRating: 5)
            
            Text(manga.attributes.tags.last?.attributes.name.en ?? "Category")
                .font(.custom(FontFamily.SFProText.light, size: 14))
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
